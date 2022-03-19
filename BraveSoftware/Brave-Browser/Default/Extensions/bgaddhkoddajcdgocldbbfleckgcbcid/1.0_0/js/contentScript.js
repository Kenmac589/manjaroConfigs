document.addEventListener('DOMContentLoaded', event => {

    chrome.tabs.query({active: true, lastFocusedWindow: true}, tabs => {

        let url = tabs[0].url;

        jQuery('#domain').text(`${new URL(url).hostname}`);

        jQuery('#no-cookies-found-domain').text(`${new URL(url).hostname}`);

        getCookiesForURL(url).then(data => {

            if(Object.keys(data).length > 0) {
                let cookies = '';
                data.forEach(datum => {
                    let expiry = 0;
                    if (datum.expirationDate) {
                        expiry = parseInt(datum.expirationDate)
                    }
                    cookies = cookies.concat(`<tr>
                                        <td>${datum['domain']}</td>
                                        <td>${(datum['domain'][0] === '.').toString().toUpperCase()}</td>
                                        <td>${datum['path']}</td>
                                        <td>${datum['secure'].toString().toUpperCase()}</td>
                                        <td>${expiry}</td>
                                        <td>${datum['name']}</td>
                                        <td>${datum['value']}</td>
                                        <tr/>`)
                });

                jQuery('.table tbody').append(cookies);
                jQuery('#content').toggle('display');
            } else {
                jQuery('#no-cookies-found').toggle('display');
            }
        });
    });

    let getCookiesForActiveTab = (() => {
        chrome.tabs.query({active: true, lastFocusedWindow: true}, tabs => {

            let url = tabs[0].url;
            getCookiesForURL(url).then(data => {

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
                    filename: `${getHost(tabs[0].url)}_cookies.txt`,
                    conflictAction: "overwrite"
                });
            });
        });
    });

    document.getElementById("download").addEventListener('click', (event) => {
        getCookiesForActiveTab();
    });

}, false);
