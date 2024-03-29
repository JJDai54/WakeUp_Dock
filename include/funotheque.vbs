Dim oShell: Set oShell = CreateObject("WScript.Shell")
'wscript.scriptFullName,64,"Chemin Absolu du script en cours"
'MsgBox wscript.scriptname,64,"Nom du script en cours"

class Funotheque

' Parameterless Constructor
Public sub Class_Initialize()

end sub

' Default initialization method that can be invoked without
' explicitly using the method name.
Public Default function Init()
        Set Init = Me
end function

'----------------------------------------------
'
'----------------------------------------------
' function sleep (nbSecondes) 
' dim sFilePath 
' 
'   sFilePath =  "include\sleep.vbs"
'   sleep = oShell.Run (sFilePath & " " & nbSecondes, 1, True)
' 
' end function
'----------------------------------------------
'
'----------------------------------------------
function load_iniFile (sFilePath) 
dim tsConfig, line, row, t, mobidic
dim name, value

'''oShell.scriptFullName,64,"Chemin Absolu du script en cours"

'dim fso:    Set fso = CreateObject("Scripting.FileSystemObject" )
  'sFilePath =  "config.ini"
  Set tsConfig = fso.OpenTextFile (sFilePath, 1) 
  set mobidic = CreateObject("Scripting.Dictionary") 'Cr�ation du dictionnaire
 
  row = 0
  Do Until tsConfig.AtEndOfStream
    line = trim(tsConfig.Readline)
    line = replace(line,"""","")
    t = split(line, "=")
    if ubound(t) > 0 then
        name  = trim(t(0))
        value = trim(t(1))
        mobidic.Add name, value
        'msgbox name & "=" & value
    end if
    
    row = row + 1
  Loop
    
  tsConfig.close
  'alert("nbItem = " & mobidic.count)
  set load_iniFile = mobidic
end function

'----------------------------------------------
'
'----------------------------------------------
sub save_iniFile (mobidic, sFilePath, addQuote, KeyPadRight) 
dim tsConfig  
dim allKeys, h, sKey, sLine, value
  
  Set tsConfig = fso.CreateTextFile (sFilePath, true) 
 
  allKeys = mobidic.keys 'R�cup�ration des cl�s du dictionnaire 
  For h=0 To ubound(allKeys) 'Pour toutes les cl�s du dictionnaire
    if (KeyPadRight > 0) then
        sKey = left(allKeys(h)  &  String(KeyPadRight, " "), KeyPadRight)
    else
        sKey = allKeys(h) 
    end if
    
    if (addQuote) then
        value = """" & mobidic(allKeys(h)) & """"
    else
        value = mobidic(allKeys(h))
    end if
    
    sLine = sKey & "= " & value
    tsConfig.writeLine sLine
  Next

  tsConfig.close
end sub

'----------------------------------------------
'
'----------------------------------------------
function alert(msg)
    msgbox msg
end function

function get_activeDrives()
dim h
dim drives
    for h=1 to 26
        if fso.FolderExists(chr(h+64) & ":\") then
            drives = drives & chr(h+64) 
        end if
    next

    get_activeDrives = drives
end function

'----------------------------------------------
'
'----------------------------------------------
function get_files(sFolder, extension, delExtension)
dim h, root, fullPath, items
dim f, fld
    
    fullPath = replace(Mid(decodeURI(Location),9), "/","\") ''Unescape est d�pr�ci� 
    h = instrRev(fullPath, "\")
    root = left(fullPath, h)
    if sFolder<>"" then root = root & sFolder
    'alert root & chr(13) & fullPath
    'alert (root)
    set fld = fso.getFolder(root)
    items = ""
    
    for each f in fld.files
        h = instrRev(f.name, ".")
        if mid(f.name,h+1) = extension then
        'alert f.name
            if(delExtension) then
                items = items & "|" & left(f.name,h-1)
            else
                items = items & "|" & f.name
            end if
          
        end if
    next
    
    get_files = mid(items,2)
    
end function

'-------------------------------
'
'-------------------------------
function toString()

    alert "funotheque" 
end function

end class
