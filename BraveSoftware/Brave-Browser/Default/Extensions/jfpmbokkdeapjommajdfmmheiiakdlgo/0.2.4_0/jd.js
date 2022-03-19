/* globals config, Parser */
'use strict';

const locales = {
  extract: 'Cannot extract any link from selected text',
  empty: 'Command box is empty. Use options page to define one!',
  path: 'JDownloader cannot be located. Go to the options page and fix its path.',
  permission: 'To extract links from all iframes of this page, the permission is needed',
  help: `
    JDownloader -status queue
    JDownloader -status downloads
    JDownloader -status all
    JDownloader -status watchfolder
  `
};

const notify = e => chrome.notifications.create({
  type: 'basic',
  title: 'Download with JDownloader',
  iconUrl: '/data/icons/48.png',
  message: e.message || e
});

const openWithJD = (d, tab = {}) => {
  (config.pre ? config.pre.action() : Promise.resolve(false)).then(running => !running && execute(d)).then(() => {
    if (config.post) {
      config.post.action(d, tab);
    }
  }).then(() => {
    if (d.id) {
      chrome.downloads.erase({
        id: d.id
      });
    }
  }).catch(e => e && notify(e));
};

const tools = {
  cookies(url) {
    if (!url || !chrome.cookies) {
      return Promise.resolve('');
    }
    return new Promise(resolve => {
      chrome.storage.local.get({
        cookies: false
      }, prefs => prefs.cookies ? chrome.cookies.getAll({
        url
      }, arr => resolve(arr.map(o => o.name + '=' + o.value).join('; '))) : resolve(''));
    });
  },
  fetch({url, method = 'GET', headers = {}, data = {}}) {
    return new Promise((resolve, reject) => {
      const req = new XMLHttpRequest();
      req.open(method, url);
      Object.entries(headers).forEach(([key, value]) => {
        req.setRequestHeader(key, value);
      });
      req.onload = () => resolve(req);
      req.onerror = req.ontimeout = () => reject(new Error('network error'));
      // req.send(Object.entries(data).map(([key, value]) => key + '=' + encodeURIComponent(value)).join('&'));
      req.send(JSON.stringify(data));
    });
  }
};

const execute = d => {
  return new Promise((resolve, reject) => {
    chrome.storage.local.get(config.command.guess, prefs => {
      if (!prefs.executable) {
        return notify(locales.empty);
      }
      const p = new Parser();
      p.escapeExpressions = {}; // do not escape expressions
      tools.cookies(d.referrer).then(cookies => {
        // remove args that are not provided
        if (!d.referrer) {
          prefs.args = prefs.args.replace(/\s[^\s]*\[REFERRER\][^\s]*\s/, ' ');
        }
        if (!d.filename) {
          prefs.args = prefs.args.replace(/\s[^\s]*\[FILENAME\][^\s]*\s/, ' ');
          prefs.args = prefs.args.replace(/\s[^\s]*\[DISK][^\s]*\s/, ' ');
        }

        let url = d.finalUrl || d.url;
        if (Array.isArray(url)) {
          url = url.join(config.mode.sep);
        }
        if (!cookies) {
          prefs.args = prefs.args.replace('--load-cookies=[COOKIES]', '');
        }
        const termref = {
          lineBuffer: prefs.args
            .replace(/\[URL\]/g, url)
            .replace(/\[REFERRER\]/g, d.referrer)
            .replace(/\[USERAGENT\]/g, navigator.userAgent)
            .replace(/\[FILENAME\]/g, (d.filename || '').split(/[/\\]/).pop())
            .replace(/\[DISK\]/g, (d.filename || ''))
            .replace(/\\/g, '\\\\')
        };

        p.parseLine(termref);

        window.setTimeout(resolve, config.delay || 5000);
        const script = String.raw`
          const cookies = args[0];
          const command = args[1].replace(/%([^%]+)%/g, (_, n) => {
            if (n === 'ProgramFiles(x86)' && !env[n]) {
              return env['ProgramFiles'];
            }
            return env[n];
          });
          function execute () {
            const exe = require('child_process').spawn(command, args.slice(2), {
              detached: true,
              windowsVerbatimArguments: ${Boolean(config.windowsVerbatimArguments)}
            });
            let stdout = '', stderr = '';
            exe.stdout.on('data', data => stdout += data);
            exe.stderr.on('data', data => stderr += data);

            stdout += command;
            exe.on('close', code => {
              push({code, stdout, stderr});
              done();
            });
            if (${config.detached}) {
              setTimeout(() => {
                push({code: 0});
                done();
                process.exit();
              }, 5000);
            }
          }

          if (cookies) {
            const filename = require('path').join(
              require('os').tmpdir(),
              'download-with-' + require('crypto').randomBytes(4).readUInt32LE(0) + ''
            );
            require('fs').writeFile(filename, cookies, e => {
              if (e) {
                push({code: 1, stderr: 'cannot create tmp file'});
                done();
              }
              else {
                args = args.map(s => s.replace(/\[COOKIES\]/g, filename));
                execute();
              }
            });
          }
          else {
            args = args.map(s => s.replace(/\[COOKIES\]/g, '.'));
            execute();
          }
        `;
        const args = [cookies, prefs.executable, ...termref.argv];
        chrome.runtime.sendNativeMessage('com.add0n.native_client', {
          permissions: ['fs', 'path', 'os', 'child_process', 'crypto'],
          args,
          script
        }, res => {
          if (!res) {
            chrome.tabs.create({url: '/data/guide/index.html'});
            return reject(Error('got empty response'));
          }
          else if (res.code !== 0) {
            const msg = res.stderr || res.error || res.err;
            console.warn(msg);
            if (msg && msg.indexOf('ENOENT') !== -1) {
              return reject(Error(locales.path));
            }
            return reject(Error(msg));
          }
          else {
            resolve();
          }
        });
      });
    });
  });
};

let id;
const dObserver = (d, response = () => {}) => {
  const mimes = localStorage.getItem('mimes') || '';
  if (mimes.indexOf(d.mime) !== -1) {
    return false;
  }

  response();
  const url = d.finalUrl || d.url;
  if (url.startsWith('http') || url.startsWith('ftp')) {
    // prefer d.url over d.finalUrl as it might be closer to the actual page url
    const {hostname} = new URL(d.url || d.finalUrl);
    const whitelist = localStorage.getItem('whitelist') || '';
    if (whitelist) {
      const hs = whitelist.split('|');
      if (hs.some(s => !s.endsWith(hostname) && !hostname.endsWith(s))) {
        return false;
      }
    }
    if (d.url.indexOf('github.com/belaviyo/native-client') !== -1) {
      return false;
    }
    if (id === d.id || d.error) {
      return false;
    }

    chrome.downloads.pause(d.id, () => chrome.tabs.query({
      active: true,
      currentWindow: true
    }, tabs => {
      openWithJD(d, tabs && tabs.length ? tabs[0] : {});
    }));
  }
};

const state = enabled => {
  const diSupport = Boolean(chrome.downloads.onDeterminingFilename);
  const download = diSupport ? chrome.downloads.onDeterminingFilename : chrome.downloads.onCreated;
  if (enabled) {
    download.addListener(dObserver);
  }
  else {
    download.removeListener(dObserver);
  }
  const path = {
    '16': 'data/icons/' + (enabled ? '' : 'disabled/') + '16.png',
    '32': 'data/icons/' + (enabled ? '' : 'disabled/') + '32.png',
    '48': 'data/icons/' + (enabled ? '' : 'disabled/') + '48.png',
    '64': 'data/icons/' + (enabled ? '' : 'disabled/') + '64.png'
  };
  chrome.browserAction.setIcon({path});
  const title = `${config.name} (Integration is "${enabled ? 'enabled' : 'disabled'}")`;
  chrome.browserAction.setTitle({title});
};

const onCommand = (toggle = true) => {
  chrome.storage.local.get({
    enabled: false
  }, prefs => {
    const enabled = toggle ? !prefs.enabled : prefs.enabled;
    chrome.storage.local.set({
      enabled
    });
    state(enabled);
  });
};
chrome.browserAction.onClicked.addListener(onCommand);
onCommand(false);

// contextMenus
const buildContexts = () => chrome.storage.local.get({
  'context.open-link': true,
  'context.open-video': true,
  'context.grab': true,
  'context.extract': true,
  'context.test': true
}, prefs => {
  chrome.contextMenus.removeAll(() => {
    if (prefs['context.test']) {
      chrome.contextMenus.create({
        id: 'test',
        title: 'Open Download Test Page',
        contexts: ['browser_action', 'page'],
        documentUrlPatterns: ['*://*/*']
      });
    }
    if (prefs['context.open-video']) {
      chrome.contextMenus.create({
        id: 'open-video',
        title: 'Download Media or Image',
        contexts: ['video', 'audio', 'image'],
        documentUrlPatterns: ['*://*/*']
      });
    }
    if (prefs['context.open-link']) {
      chrome.contextMenus.create({
        id: 'open-link',
        title: 'Download Link',
        contexts: ['link'],
        documentUrlPatterns: ['*://*/*']
      });
    }
    if (prefs['context.grab']) {
      chrome.contextMenus.create({
        id: 'grab',
        title: 'Download all Links',
        contexts: ['page', 'browser_action'],
        documentUrlPatterns: ['*://*/*']
      });
    }
    if (prefs['context.extract']) {
      chrome.contextMenus.create({
        id: 'extract',
        title: 'Extract Links from Selection',
        contexts: ['selection'],
        documentUrlPatterns: ['*://*/*']
      });
    }
  });
});
chrome.runtime.onStartup.addListener(buildContexts);
chrome.runtime.onInstalled.addListener(buildContexts);
chrome.storage.onChanged.addListener(prefs => {
  if (Object.keys(prefs).some(s => s.startsWith('context.'))) {
    buildContexts();
  }
});

const links = {};
chrome.tabs.onRemoved.addListener(id => delete links[id]);

const grab = mode => chrome.tabs.executeScript({
  runAt: 'document_start',
  code: `window.mode = "${mode}"`
}, () => {
  const lastError = chrome.runtime.lastError;
  if (lastError) {
    notify(lastError.message);
  }
  else {
    chrome.tabs.executeScript({
      runAt: 'document_start',
      file: '/data/grab/inject.js'
    });
  }
});

chrome.contextMenus.onClicked.addListener((info, tab) => {
  if (info.menuItemId === 'test') {
    chrome.tabs.create({
      url: 'https://webbrowsertools.com/test-download-with/'
    });
  }
  else if (info.menuItemId === 'grab') {
    chrome.permissions.request({
      origins: ['*://*/*']
    }, granted => {
      if (granted) {
        grab('none');
      }
      else {
        notify(locales.permission);
      }
    });
  }
  else if (info.menuItemId === 'extract') {
    const re = /(?:(?:https?|ftp|file):\/\/|www\.|ftp\.)(?:\([-A-Z0-9+&@#/%=~_|$?!:,.]*\)|[-A-Z0-9+&@#/%=~_|$?!:,.])*(?:\([-A-Z0-9+&@#/%=~_|$?!:,.]*\)|[A-Z0-9+&@#/%=~_|$])/igm;
    const es = info.selectionText.match(re) || [];
    chrome.permissions.request({
      origins: ['*://*/*']
    }, granted => {
      if (granted) {
        chrome.tabs.executeScript(tab.id, {
          frameId: info.frameId,
          code: `window.extraLinks = ${JSON.stringify(es)};`
        }, () => {
          const lastError = chrome.runtime.lastError;
          if (lastError) {
            notify(lastError.message);
          }
          else {
            chrome.tabs.executeScript(tab.is, {
              frameId: info.frameId,
              file: 'data/grab/selection.js'
            }, a => {
              if (a && a[0]) {
                const es = a[0].filter((s, i, l) => s && l.indexOf(s) === i);
                if (es.length) {
                  links[tab.id] = es;
                  grab('serve');
                }
                else {
                  notify(locales.extract);
                }
              }
            });
          }
        });
      }
      else {
        notify('To extract links and display the interface, this permission is needed');
      }
    });
  }
  else {
    openWithJD({
      finalUrl: info.menuItemId === 'open-video' ? info.srcUrl : info.linkUrl,
      referrer: info.pageUrl
    }, tab);
  }
});

//
chrome.runtime.onMessage.addListener((request, sender, response) => {
  if (request.method === 'notify') {
    notify(request.message);
  }
  else if (request.method === 'exec') {
    chrome.tabs.executeScript({
      runAt: 'document_start',
      code: request.code,
      allFrames: true
    }, r => {
      const lastError = chrome.runtime.lastError;
      if (lastError) {
        notify(lastError.message);
      }
      else {
        response(r);
      }
    });
    return true;
  }
  else if (request.method === 'download') {
    openWithJD(Object.assign({
      referrer: sender.tab.url
    }, request.job), sender.tab);
  }
  else if (request.method === 'download-links') {
    if (config.mode.method === 'batch') {
      openWithJD({
        ...request.job,
        referrer: sender.tab.url
      }, sender.tab);
    }
    else {
      (async () => {
        const delay = () => new Promise(resolve => window.setTimeout(resolve, Number(localStorage.getItem('delay') || 1000)));

        for (const finalUrl of request.job.url) {
          openWithJD({
            finalUrl,
            referrer: sender.tab.url
          }, sender.tab);

          await delay();
        }
      })();
    }
    chrome.tabs.sendMessage(sender.tab.id, {
      cmd: 'close-me'
    });
  }
  else if (request.method === 'head') {
    const req = new XMLHttpRequest();
    req.open('GET', request.link);
    req.timeout = 10000;
    req.ontimeout = req.onerror = () => response('');
    req.onreadystatechange = () => {
      if (req.readyState === req.HEADERS_RECEIVED) {
        response(req.getResponseHeader('content-type') || '');
        req.abort();
      }
    };
    req.send();
    return true;
  }
  else if (request.method === 'extracted-links') {
    response(links[sender.tab.id] || []);
  }
});

/* FAQs & Feedback */
{
  const {management, runtime: {onInstalled, setUninstallURL, getManifest}, storage, tabs} = chrome;
  if (navigator.webdriver !== true) {
    const page = getManifest().homepage_url;
    const {name, version} = getManifest();
    onInstalled.addListener(({reason, previousVersion}) => {
      management.getSelf(({installType}) => installType === 'normal' && storage.local.get({
        'faqs': true,
        'last-update': 0
      }, prefs => {
        if (reason === 'install' || (prefs.faqs && reason === 'update')) {
          const doUpdate = (Date.now() - prefs['last-update']) / 1000 / 60 / 60 / 24 > 45;
          if (doUpdate && previousVersion !== version) {
            tabs.query({active: true, currentWindow: true}, tbs => tabs.create({
              url: page + '&version=' + version + (previousVersion ? '&p=' + previousVersion : '') + '&type=' + reason,
              active: reason === 'install',
              ...(tbs && tbs.length && {index: tbs[0].index + 1})
            }));
            storage.local.set({'last-update': Date.now()});
          }
        }
      }));
    });
    setUninstallURL(page + '&rd=feedback&name=' + encodeURIComponent(name) + '&version=' + version);
  }
}
