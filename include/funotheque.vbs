Dim oShell: Set oShell = CreateObject("WScript.Shell")

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
sub sleep (nbSecondes) 
dim sFilePath 

  sFilePath =  "sleep.vbs"
  oShell.Run sFilePath & " " & nbSecondes, 1, True

end sub
'----------------------------------------------
'
'----------------------------------------------
function load_iniFile (sFilePath) 
dim tsConfig, line, row, t, mobidic
dim name, value
'dim fso:    Set fso = CreateObject("Scripting.FileSystemObject" )
  'sFilePath =  "config.ini"
  Set tsConfig = fso.OpenTextFile (sFilePath, 1) 
  set mobidic = CreateObject("Scripting.Dictionary") 'Création du dictionnaire
 
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
 
  allKeys = mobidic.keys 'Récupération des clés du dictionnaire 
  For h=0 To ubound(allKeys) 'Pour toutes les clés du dictionnaire
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
function get_activeDrives()
dim h
dim lecteurs
    for h=1 to 26
        if fso.FolderExists(chr(h+64) & ":\") then
            lecteurs = lecteurs & chr(h+64) 
        end if
    next

    get_activeDrives = lecteurs
end function

'----------------------------------------------
'
'----------------------------------------------
function get_files(sFolder, extension, delExtension)
dim h, root, fullPath, items
dim f, fld
    
    fullPath = replace(Mid(decodeURI(Location),9), "/","\") ''Unescape est déprécié 
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
