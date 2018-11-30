AudioAddict Command Line
==================================================

[![Gem Version](https://badge.fury.io/rb/audio_addict.svg)](https://badge.fury.io/rb/audio_addict)
[![Build Status](https://travis-ci.com/DannyBen/audio_addict.svg?branch=master)](https://travis-ci.com/DannyBen/audio_addict)
[![Maintainability](https://api.codeclimate.com/v1/badges/91e1a8251b771881bf6b/maintainability)](https://codeclimate.com/github/DannyBen/audio_addict/maintainability)

---

Command line utility for performing various operations on the AudioAddict 
radio network.

**This gem is not affiliated with AudioAddict.**

---


Install
--------------------------------------------------

Please note that in order to use this gem you need to have a premium account
at one of the AudioAddict networks.

```
$ gem install audio_addict
```


Features
--------------------------------------------------

- Easy to use command line interface
- Support for all the networks on the [AudioAddict Platform]:
  - [Digitally Imported]
  - [RockRadio]
  - [RadioTunes]
  - [JazzRadio]
  - [ClassicalRadio]
- View list of channels
- View currently playing track
- Vote on the currently playing track
- Generate playlists


Usage
--------------------------------------------------

- Run the `radio` command to see a list of available subcommands.
- To see additional help, run `radio <subcommand> --help`

```
$ radio
AudioAddict Radio Utilities

Commands:
  login     Save login credentials
  status    Show configuration status
  set       Set the radio network and channel
  channels  Show list of channels
  now       Show network, channel and playing track
  vote      Vote on the currently playing track
  playlist  Generate playlists

```

---

[AudioAddict Platform]: http://www.audioaddict.com
[Digitally Imported]: http://di.fm
[RockRadio]: http://www.rockradio.com
[RadioTunes]: http://www.radiotunes.com
[JazzRadio]: http://www.jazzradio.com
[ClassicalRadio]: http://www.classicalradio.com
