; --------------------------------------------------
; This script generates the demo gif
; --------------------------------------------------
#SingleInstance Force
SetkeyDelay 0, 50

Commands := []
Index := 1

Commands.Push("cd temp")
Commands.Push("radio set vocalchil di")
Commands.Push("ttystudio demo.gif")
Commands.Push("cd temp")
Commands.Push("radio")
Commands.Push("radio now")
Commands.Push("radio set --help")
Commands.Push("radio set")
Commands.Push("radio now")
Commands.Push("radio vote")
Commands.Push("radio channels")
Commands.Push("radio channels dance")
Commands.Push("radio playlist")
Commands.Push("radio playlist init mylist")
Commands.Push("exit")

F12::
  Send % Commands[Index]
  Index := Index + 1
return

^F12::
  Reload
return

^x::
  ExitApp
return
