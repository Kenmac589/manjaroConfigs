/* globals tools */
'use strict';

const config = {
  get remote() {
    return localStorage.getItem('remote') || 'http://127.0.0.1:9666/';
  }
};
window.config = config;

config.mode = {
  get method() {
    return 'parallel';
  },
  supports: false
};


config.tag = 'jdownloader';
config.name = 'Download with JDownloader';

config.cookies = true;

Object.defineProperty(config, 'delay', {
  get() {
    return Number(localStorage.getItem('delay') || '1000');
  }
});
Object.defineProperty(config, 'autostart', {
  get() {
    return Number(localStorage.getItem('autostart') || 1);
  }
});

config.pre = {
  get url() {
    return config.remote + 'flash/';
  },
  action: () => tools.fetch(config.pre).then(() => true, () => false)
};

config.command = {
  executable: {
    Mac: 'open',
    Win: '%LocalAppData%\\JDownloader 2.0\\JDownloader2.exe',
    Lin: 'JDownloader2'
  },
  args: {
    Mac: '-a "JDownloader2"',
    Win: '',
    Lin: ''
  },
  get guess() {
    const key = navigator.platform.substr(0, 3);
    return {
      executable: config.command.executable[key],
      args: config.command.args[key]
    };
  }
};

config.post = {
  method: 'POST',
  action: (d, tab) => (d.referrer ? tools.cookies(d.referrer) : Promise.resolve('')).then(cookies => {
    let index = 0;
    const delay = t => new Promise(resolve => window.setTimeout(resolve, t));

    const body = new URLSearchParams();

    body.append('urls', d.finalUrl || d.url);
    body.append('referer', d.referrer || '');
    body.append('autostart', config.autostart);
    body.append('package', tab.title || '');
    body.append('description', 'Initiated by ' + config.name);
    body.append('cookies', cookies);
    body.append('fnames', (d.filename || '').split(/[/\\]/).pop());
    body.append('source', chrome.runtime.getURL(''));

    console.log(config.post.url, body);

    const once = () => fetch(config.post.url, {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      },
      method: 'post',
      body
    }).then(r => {
      r.text().then(c => console.log(c));
      if (!r.ok) {
        throw new Error('Connection is rejected by JDownloader');
      }
    }).catch(e => {
      index += 1;
      if (index < 20 && e.message !== 'Connection is rejected by JDownloader') {
        return delay(config.delay).then(once);
      }
      console.log(e);
      throw new Error(
        'Cannot send command to JDownloader; Make sure ' +
        config.post.url +
        ' is accessible'
      );
    });
    return new Promise(resolve => chrome.storage.local.get({
      'engine': 'flash/add'
    }, prefs => {
      config.post.url = config.remote + prefs.engine;
      resolve();
    })).then(once);
  })
};
