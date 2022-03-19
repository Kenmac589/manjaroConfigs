/* global config */
'use strict';

const $ = id => document.getElementById(id);

// testing your downloader with sample files
$('test').addEventListener('click', () => chrome.tabs.create({
  url: 'https://webbrowsertools.com/test-download-with/'
}));

function restore() {
  const mimes = (localStorage.getItem('mimes') || '').split('|');
  $('mimes').value = mimes.join(', ');

  const whitelist = (localStorage.getItem('whitelist') || '').split('|');
  $('whitelist').value = whitelist.join(', ');

  $('autostart').checked = localStorage.getItem('autostart') === '0' ? false : true;

  $('delay').value = Number(config.delay || localStorage.getItem('delay') || '1000');
  $('batch').checked = config.mode.method === 'batch';
  if (config.mode.support === false) {
    $('batch').closest('tr').style = 'opacity: 0.5; pointer-events: none;';
  }

  if (config.remote) {
    $('remote').value = config.remote;
    $('remote').closest('tr').classList.remove('hidden');
  }

  chrome.storage.local.get(Object.assign(config.command.guess, {
    'cookies': false,
    'context.open-video': true,
    'context.open-link': true,
    'context.extract': true,
    'context.grab': true,
    'context.test': true,
    'engine': 'flash/add'
  }), prefs => {
    $('context.extract').checked = prefs['context.extract'];
    $('args').value = prefs.args;
    $('executable').value = prefs.executable;
    $('context.open-link').checked = prefs['context.open-link'];
    $('cookies').checked = prefs.cookies;
    $('context.grab').checked = prefs['context.grab'];
    $('context.test').checked = prefs['context.test'];
    $('context.open-video').checked = prefs['context.open-video'];
    $('engine').value = prefs.engine;
  });
}

function save() {
  const args = $('args').value;
  const executable = $('executable').value;
  const mimes = $('mimes').value
    .split(/\s*,\s*/).filter((s, i, l) => s && l.indexOf(s) === i && s.indexOf('/') !== -1);
  localStorage.setItem('mimes', mimes.join('|'));
  const cookies = $('cookies').checked;
  const whitelist = $('whitelist').value
    .split(/\s*,\s*/).filter((s, i, l) => s && l.indexOf(s) === i);
  localStorage.setItem('autostart', $('autostart').checked ? 1 : 0);
  localStorage.setItem('whitelist', whitelist.join('|'));
  localStorage.setItem('mode', $('batch').checked ? 'batch' : 'parallel');
  localStorage.setItem('delay', Math.max(50, $('delay').value));
  localStorage.setItem('remote', $('remote').value);
  chrome.storage.local.set({
    args,
    cookies,
    executable,
    'context.open-video': $('context.open-video').checked,
    'context.open-link': $('context.open-link').checked,
    'context.extract': $('context.extract').checked,
    'context.grab': $('context.grab').checked,
    'context.test': $('context.test').checked,
    'engine': $('engine').value
  }, () => {
    const status = $('status');
    status.textContent = 'Options saved.';
    setTimeout(() => status.textContent = '', 1000);
    restore();
  });
}

document.addEventListener('DOMContentLoaded', restore);
$('save').addEventListener('click', save);

if (!config.cookies) {
  [...document.querySelectorAll('[cookies]')].forEach(e => e.classList.add('disabled'));
}
if (!('autostart' in config)) {
  [...document.querySelectorAll('[autostart]')].forEach(e => e.classList.add('disabled'));
}
// support
$('support').addEventListener('click', () => chrome.tabs.create({
  url: chrome.runtime.getManifest().homepage_url + '&rd=donate'
}));
// reset
$('reset').addEventListener('click', e => {
  if (e.detail === 1) {
    const status = $('status');
    window.setTimeout(() => status.textContent = '', 1000);
    status.textContent = 'Double-click to reset!';
  }
  else {
    localStorage.clear();
    chrome.storage.local.clear(() => {
      chrome.runtime.reload();
      window.close();
    });
  }
});
// check cookies permission status
$('cookies').addEventListener('change', e => {
  if (e.target.checked) {
    chrome.permissions.request({
      permissions: ['cookies'],
      origins: ['*://*/*']
    }, granted => {
      if (!granted) {
        e.target.checked = false;
      }
    });
  }
});
// YT Links
$('yt-linux').addEventListener('click', () => chrome.tabs.create({
  url: 'https://www.youtube.com/watch?v=2asPoW2gJ-c'
}));
$('yt-windows').addEventListener('click', () => chrome.tabs.create({
  url: 'https://www.youtube.com/watch?v=yZAoy8SOd7o'
}));
$('preview').addEventListener('click', () => chrome.tabs.create({
  url: 'https://www.youtube.com/watch?v=vSnZp2wflTc'
}));
