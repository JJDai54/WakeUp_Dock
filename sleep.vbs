
dim tempo
public zzz

    if  WScript.Arguments.Count > 0 then
        tempo = WScript.Arguments(0)
    else
        tempo = 60
    end if

    'msgbox ("debut tempo")
    WScript.Sleep(tempo * 1000)  
   ''' msgbox ("fin tempo - " & tempo) 
    
    WScript.Quit

