; --------------------------------------------------
; This script generates the demo gif
; NOTE: This should be executed in the root folder
; --------------------------------------------------
#SingleInstance Force
SetkeyDelay 0, 50

Return

Type(Command, Delay=2000) {
  Send % Command
  Sleep 500
  Send {Enter}
  Sleep Delay
}

F12::
  Type("{#} F11 aborts")
  Type("cd ./support/demo")
  Type("rm -f mylist.*")
  Type("radio set vocalchil di")
  Type("rm cast.json {;} asciinema rec cast.json")

  Type("radio")
  Type("radio now")
  Type("radio set --help")
  Type("radio set")
  Send {Down}
  Sleep 300
  Send {Up}
  Sleep 300
  Send {Enter}
  Sleep 1000
  Send danc
  Sleep 500
  Send {Down}
  Sleep 300
  Send {Down}
  Sleep 300
  Send {Down}
  Sleep 300
  Send {Enter}
  Type("radio now")
  Type("radio vote", 2000)
  Type("n")
  Type("radio channels")
  Type("radio channels dance")
  Type("radio playlist")
  Type("radio playlist init mylist", 1000)
  Type("y", 1000)
  Type("y", 1000)
  Type("exit")

  Type("agg --font-size 20 cast.json cast.gif")
  Sleep 400
  Type("cd ../../")
  Type("{#} Done")
Return

^F12::
  Reload
return

F11::
  ExitApp
return
