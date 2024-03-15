/* ***
 * 
 * ***/
function getPosObj(obName){
alert (obName);
var ob = document.getElementById(obName);
alert (ob.id);
    alert(ob.getAttribute('top'));

}
/* ***
 * 
 * ***/
function jsGetAppPath(){
    return WakeUpDockHTA.commandLine;
}
/* ***
 * 
 * ***/
function jsLoadLecteurs(drives, letterDefault){
    var obList = document.getElementById("lstDrives");
    obList.innerHTML = ""
    for (var h = 0; h < drives.length; h++){
        var letter = drives.substr(h, 1);
        var newOption = new Option(letter, letter);
        obList.add(newOption);
    }
        if (letterDefault.length > 0) obList.value=letterDefault;    
//alert(drives);
}
/* ***
 * 
 * ***/
function jsLoadList(id, items, vDefault){
    var obList = document.getElementById(id);
    var tItems = items.split("|");
    for (var h=0; h<tItems.length; h++){
        var newOption = new Option(tItems[h], tItems[h]);
        obList.add(newOption);
    }
        if (vDefault.length > 0) obList.value=vDefault;    
}

function getDrivesChecked(){
var lstDrives = ""
    var divDrives = document.getElementById("divDrives");
    var obDrives = divDrives.children;
    //alert (divDrives.name + "-" + obDrives.length);
    for (var h=0; h<obDrives.length; h++){
        var child = obDrives[h];
        //alert(child.tagName );
        if (child.tagName == "INPUT" && child.checked){
        //alert(child.tagName + "-" +  child.checked);
            lstDrives += child.value;
        }
    }
    return (lstDrives.toUpperCase());
}


