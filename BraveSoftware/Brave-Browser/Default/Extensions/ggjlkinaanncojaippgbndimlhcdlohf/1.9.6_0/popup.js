if (chrome){
	browser = chrome
}
document.querySelectorAll('[data-locale]').forEach(elem => {
	elem.innerText = chrome.i18n.getMessage(elem.dataset.locale)
})

chrome.storage.sync.get("showRating",function(obj){
	if (obj.showRating == "false") {
		// User has already rated
	}
	else {
		document.getElementById("rating").style.display = "block";
	}
})

// chrome.storage.sync.get("counter",function(obj){
// 	if (obj.counter == undefined) {
// 		
// 	}
// 	else {
// 		document.getElementById("theCounter").innerHTML= obj.counter;
// 	}
// 	
// })

document.getElementById("fetchPaper").addEventListener("click",
	function(){
		browser.runtime.sendMessage({clicked : true});
	}
)

document.getElementById("settings").addEventListener("click",
	function(){
		browser.runtime.openOptionsPage()
	}
)

document.getElementById("instructions").addEventListener("click",
	function(){
		browser.tabs.create({url: chrome.i18n.getMessage("instructionsURL")})
	}
)

document.getElementById("rating-star-5").addEventListener("click",
	function(){
		browser.tabs.create({url: "https://chrome.google.com/webstore/detail/paperpanda/ggjlkinaanncojaippgbndimlhcdlohf/reviews"})
		chrome.storage.sync.set({"showRating": "false"},function(){})
		document.getElementById("rating").style.display = "none";
	}
)

document.getElementById("rating-star-4").addEventListener("click",
	function(){
		setTimeout(function (){
		  document.getElementById("rating-stars").style.display = "none";
		}, 100);
		setTimeout(function (){
			document.getElementById("rating-thanks").style.display = "block";
		}, 100);
		setTimeout(function (){
			document.getElementById("rating").style.display = "none";
		}, 500);
		chrome.storage.sync.set({"showRating": "false"},function(){})
	}
)
document.getElementById("rating-star-3").addEventListener("click",
	function(){
		setTimeout(function (){
		  document.getElementById("rating-stars").style.display = "none";
		}, 100);
		setTimeout(function (){
			document.getElementById("rating-thanks").style.display = "block";
		}, 100);
		setTimeout(function (){
			document.getElementById("rating").style.display = "none";
		}, 500);
		chrome.storage.sync.set({"showRating": "false"},function(){})
	}
)
document.getElementById("rating-star-2").addEventListener("click",
	function(){
		setTimeout(function (){
		  document.getElementById("rating-stars").style.display = "none";
		}, 100);
		setTimeout(function (){
			document.getElementById("rating-thanks").style.display = "block";
		}, 100);
		setTimeout(function (){
			document.getElementById("rating").style.display = "none";
		}, 500);
		chrome.storage.sync.set({"showRating": "false"},function(){})
	}
)
document.getElementById("rating-star-1").addEventListener("click",
	function(){
		setTimeout(function (){
		  document.getElementById("rating-stars").style.display = "none";
		}, 100);
		setTimeout(function (){
			document.getElementById("rating-thanks").style.display = "block";
		}, 100);
		setTimeout(function (){
			document.getElementById("rating").style.display = "none";
		}, 500);
		chrome.storage.sync.set({"showRating": "false"},function(){})
	}
)




chrome.storage.sync.get("showRec",function(obj){
	if (obj.showRec == "false") {
		// User has closed the recommendations
	}
	else {
		renderR();
	}
})
document.getElementById("menuRecItemX").addEventListener("click",
function(){
	setTimeout(function (){
	  document.getElementById("menuRec").style.display = "none";
	}, 100);
	
	chrome.storage.sync.set({"showRec": "false"},function(){})
}
)

async function getR() {
	let url = "https://paperpanda.app/r.json";
	try {
		let res = await fetch(url);
		return await res.json();
	} catch (error) {
		console.log(error);
	}
}
async function renderR() {
	let r = await getR();
	// console.log(r);
	const recItems = Object.values(r)
	const Rec = recItems[parseInt(Math.random() * recItems.length)]
	// console.log(Rec);
	document.getElementById("menuRecItemName").textContent = Rec["name"];
	document.getElementById("menuRecItemTagline").textContent = Rec["tagline"];
	document.getElementById("menuRecItemButton").setAttribute("href", Rec["link"]);
	document.getElementById("menuRec").style.display = "block";
}





// document.getElementById("share_twitter").addEventListener("click",
// function(){
// 	window.open('https://twitter.com/intent/tweet?url=https://paperpanda.app&text=I use the PaperPanda Chrome Extension to find and download millions of research paper PDFs', 'tweet', 'height=320, width=640, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no, status=no');
// 	return false;
// }
// )
// 
// document.getElementById("share_fb").addEventListener("click",
// function(){
// 	window.open('https://www.facebook.com/sharer/sharer.php?u=https://paperpanda.app', 'facebook_share', 'height=320, width=640, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no, status=no');
// 	return false;
// }
// )
// 
// document.getElementById("share_linkedin").addEventListener("click",
// function(){
// 	window.open('https://www.linkedin.com/shareArticle?mini=true&url=https://paperpanda.app&title=https://paperpanda.app', 'linkedin', 'height=560, width=560, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no, status=no');
// 	return false;
// }
// )
// 
// document.getElementById("share_whatsapp").addEventListener("click",
// function(){
// 	window.open('https://api.whatsapp.com/send/?phone&text=https://paperpanda.app&app_absent=0', 'whatsapp', 'height=560, width=560, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no, status=no');
// 	return false;
// }
// )
// 
// document.getElementById("share_wechat").addEventListener("click",
// function(){
// 	window.open('https://paperpanda.app/qr', 'wechat', 'height=560, width=560, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no, status=no');
// 	return false;
// }
// )
// 
// 
// document.getElementById("share_weibo").addEventListener("click",
// function(){
// 	window.open('https://service.weibo.com/share/share.php?url=https://paperpanda.app', 'weibo', 'height=560, width=560, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no, status=no');
// 	return false;
// }
// )
// 
// document.getElementById("share_qq").addEventListener("click",
// function(){
// 	window.open('https://connect.qq.com/widget/shareqq/index.html?url=https://paperpanda.app', 'qq', 'height=560, width=560, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no, status=no');
// 	return false;
// }
// )
// 
// document.getElementById("share_qzone").addEventListener("click",
// function(){
// 	window.open('https://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=https://paperpanda.app', 'qzone', 'height=560, width=560, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no, status=no');
// 	return false;
// }
// )
