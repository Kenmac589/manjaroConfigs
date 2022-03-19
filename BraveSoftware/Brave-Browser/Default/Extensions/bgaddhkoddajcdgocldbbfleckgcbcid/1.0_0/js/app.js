console = chrome.extension.getBackgroundPage().console;

let getHost = param => {
    if(param.toString().match(/http(s?):\/\//)) {
        let url = new URL(param);
        url = url.host.replace('www.', '');
        if (url.split('.').length > 2) {
            let splits = url.split('.');
            splits.shift();
            return splits.join('.');
        }
        return url;
    }
}

let getCookiesForURL = url => {
    return new Promise(resolve => {
        chrome.cookies.getAll({}, (cookies) => {
            resolve(cookies.filter(cookie => cookie.domain.indexOf(getHost(url)) !== -1));
        });
    });
};

chrome.runtime.onStartup.addListener(function () {
    chrome.contextMenus.create({
        "id": "getCookiesDotTxt",
        "title": "Get cookies.txt",
        "documentUrlPatterns": [
            "http://*/*",
            "https://*/*"
        ]
    });
});

chrome.runtime.onInstalled.addListener(function () {
    chrome.contextMenus.create({
        "id": "getCookiesDotTxt",
        "title": "Get cookies.txt",
        "documentUrlPatterns": [
            "http://*/*",
            "https://*/*"
        ]
    });
});

chrome.webNavigation.onCompleted.addListener(details => {
    chrome.tabs.query({active: true, lastFocusedWindow: true}, tabs => {
        let url = tabs[0].url;
        getCookiesForURL(url).then(value => {
            chrome.browserAction.setBadgeText({
                text: Object.keys(value).length.toString(),
                tabId: tabs[0].id
            });
        });
    });
});

chrome.browserAction.onClicked.addListener(tab => {
    chrome.browserAction.getPopup({tabId: tab.id}, result => {
        console.log(result);
    });
});

chrome.contextMenus.onClicked.addListener(((info, tab) => {

    getCookiesForURL(tab.url).then(data => {

        let metadata = '# Netscape HTTP Cookie File\n# http://curl.haxx.se/rfc/cookie_spec.html\n# This is a generated file!  Do not edit.\n'
        let cookies = '';

        data.forEach(datum => {
            let expiry = 0;
            if (datum.expirationDate) {
                expiry = parseInt(datum.expirationDate)
            }
            cookies = cookies.concat(`\n${datum['domain']}\t${(datum['domain'][0] === '.').toString().toUpperCase()}\t${datum['path']}\t${datum['secure'].toString().toUpperCase()}\t${expiry}\t${datum['name']}\t${datum['value']}`)
        });

        let blob = new Blob([metadata.concat(cookies)], {type: "text/plain"});
        let url = URL.createObjectURL(blob);

        chrome.downloads.download({
            url: url,
            filename: `${getHost(tab.url)}_cookies.txt`,
            conflictAction: "overwrite"
        });
    });
}));
