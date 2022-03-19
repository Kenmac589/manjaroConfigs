var ownBitmap;
var storedCanvas = document.createElement('canvas');
var ownIconSelected = false;
var targetWindow = null;

function save() {
	var prefs = JSON.parse(window.localStorage.merge_windows_prefs);
    
    prefs.yellowIcon = document.getElementById("yellowIcon").checked;
    prefs.greenIcon = document.getElementById("greenIcon").checked;
    prefs.blueIcon = document.getElementById("blueIcon").checked;
    prefs.redIcon = document.getElementById("redIcon").checked;
    prefs.defaultIcon = document.getElementById("defaultIcon").checked;
    prefs.ownIcon = document.getElementById("ownIcon").checked;
    if(prefs.ownIcon && ownIconSelected)prefs.storedCanvas = storedCanvas.toDataURL("image/png");
    
    window.localStorage.merge_windows_prefs = JSON.stringify(prefs);
    
    //update icon
    if (prefs.yellowIcon)
        chrome.browserAction.setIcon({path:"yellow.png"})
    else if (prefs.greenIcon)
        chrome.browserAction.setIcon({path:"green.png"})   
    else if (prefs.blueIcon)
        chrome.browserAction.setIcon({path:"blue.png"})   
    else if (prefs.redIcon)
        chrome.browserAction.setIcon({path:"red.png"})  
    else if (prefs.ownIcon && prefs.storedCanvas!=null)chrome.browserAction.setIcon({imageData:ownBitmap})      
    else
		chrome.browserAction.setIcon({path:"icon24.png"});
    
	
	
	//chrome.extension.getBackgroundPage().init();
}

function getHostname(data) {
  var    a      = document.createElement('a');
         a.href = data;
    
  return (a.protocol+'//'+a.hostname);
}

function start() {
  chrome.windows.getCurrent(getWindows);
}

function getWindows(win) {
  targetWindow = win;
  chrome.tabs.getAllInWindow(targetWindow.id, getTabs);
}

function getTabs(tabs) {
  tabCount = tabs.length;
  // We require all the tab information to be populated.
  chrome.windows.getAll({"populate" : true}, moveTabs);
}

function moveTabs(windows) {
  var numWindows = windows.length;
  var tabPosition = tabCount;

    var body = document.getElementById("currOpen"),
        tbl  = document.createElement('table');
    
    tbl.style.width  = '100%';
    tbl.style.border = '1px solid black';
    tbl.style.tableLayout = 'fixed';

    var myTable = [];
    if (localStorage.getItem("exclusionList") === null) {
        //not set
    } else{ 
        myTable=JSON.parse( localStorage.exclusionList ); 
    }
    
  for (var i = 0; i < numWindows; i++) {
    var win = windows[i];


      var numTabs = win.tabs.length;

      for (var j = 0; j < numTabs; j++) {
        var tab = win.tabs[j];
          var tr = tbl.insertRow();
            tr.style.border = '0px solid black';
          
        // walk trough all tabs
        //(tab.id,targetWindow.id)
        //  console.log(tab.id,tab.url,tab.title,win.id);

          var td = tr.insertCell();
                td.appendChild(document.createTextNode(tab.title));
                td.style.border = '1px solid black';
                td.style.margin = '0px';
          var td = tr.insertCell();
                td.appendChild(document.createTextNode(getHostname(tab.url)));
                td.style.border = '1px solid black';
                td.style.margin = '0px';
                td.style.whiteSpace = 'normal';
          var td = tr.insertCell();
          td.style.width='150px';
          var button = document.createElement('button');
                  button.innerHTML = '[+] add exclusion';
                  button.href = getHostname(tab.url); 
                  button.name = tab.title;
          button.style.width="100%";
                    button.onclick = function(){
                           var myTable = [];
                            if (localStorage.getItem("exclusionList") === null) {
                                //not set
                            } else{ 
                                myTable=JSON.parse( localStorage.exclusionList ); 
                            } 
                        //console.log(this.href)
                        //document.getElementById("TF_rules").value += this.href+'\n';
                          var table = document.getElementById("TF_rules");
                          var row = table.insertRow();
                          var cell1 = row.insertCell(0);
                          var cell2 = row.insertCell(1);
                          var cell3 = row.insertCell(2);
                        cell3.style.width='150px';
                          cell1.innerHTML = this.name;
                          cell2.innerHTML = this.href;
                          cell2.href = this.href;
                          cell1.style.border = "1px solid black";
                          cell2.style.border = "1px solid black";
                        myTable.push({name:this.name,url:this.href});
                        localStorage.exclusionList = JSON.stringify( myTable );
                        
                           var button1 = document.createElement('button');
                           button1.innerHTML = '[x] remove';
                        button1.style.width="100%";
                           button1.href = this.href;
                            button1.onclick = function(){ 
                                //iterate table and delete row with this url
                                
                                var table1 = document.getElementById("TF_rules");
                                myTable = [];
                                //for (var i = 0, row1; row1 = table1.rows[i]; i++) {
                                var len=table1.rows.length;
                                for (var i = 0; i < len; i++){
                                   row1 = table1.rows[i]; 
                                   //iterate through rows
                                   //rows would be accessed using the "row1" variable assigned in the for loop
                                   col1 = row1.cells[1].href;                                    
                                    //console.log(col1.href)
                                    //console.log(this.href)
                                    //console.log(i);
                                    
                                    if(!col1.toString().localeCompare(this.href)){
                                        //console.log(i);
                                        table1.deleteRow(i);
                                        i--;len--;
                                                                            
                                        //return;
                                    } else { 
                                        
                                        
                                    }
         
                                }
                                //read the table again
                                for (var i = 0; i < table1.rows.length; i++){
                                    row1 = table1.rows[i]; 
                                    col1 = row1.cells[1]; 
                                    colA = row1.cells[0].textContent; 
                                    myTable.push({name:colA,url:col1});
                                    //console.log(row1.cells)
                                }
                                localStorage.exclusionList = JSON.stringify( myTable );
                            }
                            cell3.appendChild(button1);
                    }
          td.appendChild(button);
          
                td.style.border = '1px solid black';
                td.style.margin = '0px';
          
      }

  }
    body.appendChild(tbl);
    //console.log(('*'))
    //console.log(myTable);
    
}

function getRules(){
    //load exclusions
    var retrievedTable = [];
    if (localStorage.getItem("exclusionList") === null) {
        //not set
    } else{ 
        retrievedTable=JSON.parse( localStorage.exclusionList ); 
    }

    //create html table
//console.log(retrievedTable)
    var table = document.getElementById("TF_rules");
    table.style.width  = '100%';
    table.style.border = '1px solid black';
    table.style.tableLayout = 'fixed';
    
    for (var i = 0; i < retrievedTable.length; i++){
                var rowL = retrievedTable[i]; 
                col1 = (rowL.url); 
                colA = rowL.name; 
                                
                        //{               
                          var row = table.insertRow();
                          var cell1 = row.insertCell(0);
                          var cell2 = row.insertCell(1);
                          var cell3 = row.insertCell(2);
                          cell3.style.width='150px';
                          cell1.innerHTML = colA;
                          cell2.innerHTML = col1;
                          cell2.href = col1;
                          cell1.style.border = "1px solid black";
                          cell2.style.border = "1px solid black";
                                                                        
                           var button1 = document.createElement('button');
                           button1.innerHTML = '[x] remove';
        button1.style.width="100%";
                           button1.href = col1;
                            button1.onclick = function(){ 
                                //iterate table and delete row with this url
                                
                                var table1 = document.getElementById("TF_rules");
                                myTable = [];
                                //for (var i = 0, row1; row1 = table1.rows[i]; i++) {
                                var len=table1.rows.length;
                                for (var i = 0; i < len; i++){
                                   row1 = table1.rows[i]; 
                                   //iterate through rows
                                   //rows would be accessed using the "row1" variable assigned in the for loop
                                   col1 = row1.cells[1].href;                                    
                                    //console.log(col1.href)
                                    //console.log(this.href)
                                    //console.log(i);
                                    
                                    if(!col1.toString().localeCompare(this.href)){
                                        //console.log(i);
                                        table1.deleteRow(i);
                                        i--;len--;
                                                                            
                                        //return;
                                    } else { 
                                        
                                        
                                    }
         
                                }
                                //read the table again
                                for (var i = 0; i < table1.rows.length; i++){
                                    row1 = table1.rows[i]; 
                                    col1 = row1.cells[1].href; 
                                    colA = row1.cells[0].textContent; 
                                    myTable.push({name:colA,url:col1});
                                    //console.log(row1.cells)
                                }
                                localStorage.exclusionList = JSON.stringify( myTable );
                            }
                            cell3.appendChild(button1);
                        //}
        
            }
    
    start();
}

function addExclusion(){
    //add custom exclusion
    if (document.getElementById("host").value.trim() === '') return; //empty string for hostname, discard
 {
                           var myTable = [];
                            if (localStorage.getItem("exclusionList") === null) {
                                //not set
                            } else{ 
                                myTable=JSON.parse( localStorage.exclusionList ); 
                            } 

                          var table = document.getElementById("TF_rules");
                          var row = table.insertRow();
                          var cell1 = row.insertCell(0);
                          var cell2 = row.insertCell(1);
                          var cell3 = row.insertCell(2);
                        cell3.style.width='150px';
                         var thisName = document.getElementById("name").value;
                         var thisHost = document.getElementById("host").value;
                        
                          cell1.innerHTML = thisName;
                          cell2.innerHTML = thisHost;
                          cell2.href = thisHost;
                          cell1.style.border = "1px solid black";
                          cell2.style.border = "1px solid black";
                        myTable.push({name:thisName,url:thisHost});
                        localStorage.exclusionList = JSON.stringify( myTable );
                        
                           var button1 = document.createElement('button');
                           button1.innerHTML = '[x] remove';
                        button1.style.width="100%";
                           button1.href = thisHost;
                            button1.onclick = function(){ 
                                //iterate table and delete row with this url                   
                                var table1 = document.getElementById("TF_rules");
                                myTable = [];
                                //for (var i = 0, row1; row1 = table1.rows[i]; i++) {
                                var len=table1.rows.length;
                                for (var i = 0; i < len; i++){
                                   row1 = table1.rows[i]; 
                                   //iterate through rows
                                   //rows would be accessed using the "row1" variable assigned in the for loop
                                   col1 = row1.cells[1].href;                                    
                                    
                                    if(!col1.toString().localeCompare(thisHost)){
                                        //console.log(i);
                                        table1.deleteRow(i);
                                        i--;len--;

                                    } else { 
                                        
                                        
                                    }
         
                                }
                                //read the table again
                                for (var i = 0; i < table1.rows.length; i++){
                                    row1 = table1.rows[i]; 
                                    col1 = row1.cells[1]; 
                                    colA = row1.cells[0].textContent; 
                                    myTable.push({name:colA,url:col1});
                                }
                                localStorage.exclusionList = JSON.stringify( myTable );
                            }
                            cell3.appendChild(button1);
}   
}

window.onload = function() {

    var prefs;
    if (!window.localStorage.merge_windows_prefs) {
		window.localStorage.merge_windows_prefs = JSON.stringify({ "defaultIcon": true});
	}
    prefs = JSON.parse(window.localStorage.merge_windows_prefs);

    document.getElementById("yellowIcon").checked = prefs.yellowIcon;
    document.getElementById("greenIcon").checked = prefs.greenIcon;
    document.getElementById("blueIcon").checked = prefs.blueIcon;
    document.getElementById("redIcon").checked = prefs.redIcon;
    document.getElementById("defaultIcon").checked = prefs.defaultIcon;
    document.getElementById("ownIcon").checked = prefs.ownIcon;
    
    //default icon by default ;-)
    if (!prefs.yellowIcon &&!prefs.greenIcon &&!prefs.blueIcon &&!prefs.redIcon &&!prefs.defaultIcon &&!prefs.ownIcon )document.getElementById("defaultIcon").checked = true;
    
    document.getElementById("yellowIcon").onclick = function() { save(); };
    document.getElementById("greenIcon").onclick = function() { save(); };
    document.getElementById("blueIcon").onclick = function() { save(); };
    document.getElementById("redIcon").onclick = function() { save(); };
    document.getElementById("defaultIcon").onclick = function() { save(); };
    document.getElementById("ownIcon").onclick = function() { save(); };
    
    document.getElementById("addex").onclick = function() { addExclusion(); };
    
    document.getElementById("errorMessage").innerHTML='';
    
    //load custom icon, if set
    if (prefs.storedCanvas!=null){
        var img = new Image();
        img.onload = function(){
            var canvas = document.createElement('canvas');
                                canvas.width = img.width;
                                canvas.height = img.height;

                                var context = canvas.getContext('2d');
                                   context.drawImage(img, 0, 0);             
                                // ...draw to the canvas...
                                var imageData = context.getImageData(0, 0, 19, 19);
            if(img.width>19 || img.width>19)document.getElementById("errorMessage").innerHTML='Image is '+img.width+'x'+img.height+' pixels. Only the top/left 19x19 pixels are used!';
                                    
            if (prefs.ownIcon)chrome.browserAction.setIcon({imageData:imageData});
                                    ownBitmap = imageData;
                        storedCanvas = canvas;
        };
        img.setAttribute("src", prefs.storedCanvas);
        document.getElementById('destination').appendChild(img);
        
    }
    getRules();
}

document.getElementById('upload-file').addEventListener('change', function() {
	var file;
	var destination = document.getElementById('destination');
	destination.innerHTML = '';

		file = this.files[0];
		if(file.type.indexOf('image') != -1) { // Very primitive "validation"

			var reader = new FileReader();

			reader.onload = function(e) {
				var img = new Image();
                
                    img.onload = function(){
                
                                var canvas = document.createElement('canvas');
                                canvas.width = img.width;
                                canvas.height = img.height;

                                var context = canvas.getContext('2d');
                                   context.drawImage(img, 0, 0);             
                                // ...draw to the canvas...
                                var imageData = context.getImageData(0, 0, 19, 19);
                               //show error if large image
                        document.getElementById("errorMessage").innerHTML='';
                            if(img.width>19 || img.width>19)document.getElementById("errorMessage").innerHTML='Image is '+img.width+'x'+img.height+' pixels. Only the top/left 19x19 pixels are used!';
                        
                        ownBitmap = imageData;
                        storedCanvas = canvas;
                        save();
                            
                    };
                
                img.src = e.target.result; // File contents here

                destination.appendChild(img);
			
			 };
                reader.readAsDataURL(file);
           document.getElementById("ownIcon").checked=true;
            ownIconSelected=true;
		} else {
            //not an image?
            destination.innerHTML = 'Wrong File...';
            document.getElementById("errorMessage").innerHTML='';
        }
	
});
