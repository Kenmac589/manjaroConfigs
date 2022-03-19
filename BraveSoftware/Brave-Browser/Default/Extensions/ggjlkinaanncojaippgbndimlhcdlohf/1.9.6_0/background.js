if (typeof chrome !== "undefined" && chrome){
  browser = chrome
}

function showWelcomePage(){
  browser.tabs.create({url: chrome.i18n.getMessage("welcomeURL")}, function (tab) {});
}
browser.runtime.onInstalled.addListener(function (object) {
    if(object.reason === 'install') {
      showWelcomePage()
    }
});
chrome.runtime.setUninstallURL(chrome.i18n.getMessage("goodbyeURL"), null);

const doiRegex = new RegExp(
  /\b(10[.][0-9]{4,}(?:[.][0-9]+)*\/(?:(?!["&\'<>])\S)+)\b/
);

var paperURL;
const trueRed = "#BC243C";
var autoCheckServer = true;
const defaults = {
  "paper-url": "https://sci-hub.ru/",
  "open-in-new-tab": true,
  "autocheck-server": true
};

function setthing(name, value) {
  switch(name) {
    case "paper-url":
      paperURL = value;
      break;
    case "open-in-new-tab":
      openInNewTab = value;
      break;
    case "autocheck-server":
      autoCheckServer = value;
      break;
  }
}
function initialize(name) {
  chrome.storage.local.get([name], function(result) {
    if (!(name in result)) {
      result[name] = defaults[name];
      chrome.storage.local.set(result, function () {});
    }
    setthing(name, result[name]);
  })
}
function checkServerStatus() {
  var img = document.body.appendChild(document.createElement("img"));
  img.height = 0;
  img.visibility = "hidden";
  img.onerror = function () {
    if (confirm("Looks like the domain "+paperURL+" is not working.  Would you like to go to the options page to select a different domain?")) {
      browser.tabs.create({url: 'chrome://extensions/?options=' + chrome.runtime.id}).then();
    }
  }
  img.src = paperURL + "/misc/img/raven_1.png";
}


function increaseCounter() {
  
  chrome.storage.sync.get("counter",function(obj){
    var counter = obj.counter;
    if (counter == undefined) {
      var counter = 0;
      chrome.storage.sync.set({"counter": 0},function(){})
    }
    
    counter++;
    chrome.storage.sync.set({"counter": counter},function(){})
    
  })
}

function getHtml(htmlSource) {
  htmlSource = htmlSource[0];
  foundRegex = htmlSource.match(doiRegex);
  if (foundRegex) {
    foundRegex = foundRegex[0].split(";")[0];
    if (openInNewTab) {
      browser.tabs.create({
        url: "https://my.paperpanda.app/go?go=" + paperURL + foundRegex,
      });
      increaseCounter();
    } else {
      browser.tabs.update(undefined, {url: "https://my.paperpanda.app/go?go=" + paperURL + foundRegex});
      increaseCounter();
    }
  }
  else {
    chrome.tabs.query({active: true, lastFocusedWindow: true}, tabs => {
      let pageURL = tabs[0].url;
      console.log(pageURL);
      let archiveURL = 'https://my.paperpanda.app/go?go=https://archive.is/?run=1&url=';

     const getHostname = (url) => {
       return new URL(url).hostname;
     }
     pageDomain = getHostname(pageURL);

      let pageDomains = [
        'www.nytimes.com', 
        'www.telegraph.co.uk', 
        'www.newyorker.com', 
        'www.washingtonpost.com', 
        'www.latimes.com',
        'hbr.org',
        'foreignpolicy.com',
        'www.ft.com',
        'www.britannica.com',
        'baltimoresun.com',
        'www.bloomberg.com',
        'www.bostonglobe.com',
        'sloanreview.mit.edu',
        'www.technologyreview.com',
        'www.lrb.co.uk',
        'medium.com',
        'www.nzherald.co.nz',
        'asia.nikkei.com',
        'qz.com',
        'thediplomat.com',
        'www.theglobeandmail.com',
        'www.vanityfair.com',
        'www.zeit.de',
        'www.wired.com',
        'www.vulture.com',
        'slate.com'
      ];
      
      
      if (pageDomains.indexOf(pageDomain) != -1) {
        if (openInNewTab) {
          browser.tabs.create({
            url: archiveURL + pageURL,
          });
        } else {
          browser.tabs.update(undefined, {url: archiveURL + pageURL});
        }
      }
      
      
      
      
      
      
      
      
  });
  }
}

function executeJs() {
  chrome.tabs.executeScript( null, {code:"document.body.innerHTML"}, function(results){ getHtml(results); } );
}

// browser.contextMenus.create({
//   id: "doi-selection",
//   title: "PaperPanda",
//   contexts: ["selection","link"],
// });
// 
// browser.contextMenus.onClicked.addListener((info, tab) => {
//   var doi = info.linkUrl;
//   doi = doi ? doi.match(doiRegex)[0].split(";")[0] : doi;
//   if (!doi) {
//     doi = info.selectionText;
//   }
//   var creatingTab = browser.tabs.create({
//     url: paperURL + doi,
//   });
//   increaseCounter();
// });

chrome.runtime.onMessage.addListener( function (message, sender, sendResponse) {
  if (message.clicked) {
    executeJs();
  }
});


browser.browserAction.onClicked.addListener(executeJs);
for (const property in defaults) {
  initialize(property);
}
