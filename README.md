AudioAddict Command Line
==================================================

[![Gem Version](https://badge.fury.io/rb/audio_addict.svg)](https://badge.fury.io/rb/audio_addict)
[![Build Status](https://github.com/DannyBen/audio_addict/workflows/Test/badge.svg)](https://github.com/DannyBen/audio_addict/actions?query=workflow%3ATest)
[![Maintainability](https://api.codeclimate.com/v1/badges/91e1a8251b771881bf6b/maintainability)](https://codeclimate.com/github/DannyBen/audio_addict/maintainability)

---

Command line utility for performing various operations on the AudioAddict 
radio network.

**This gem is not affiliated with AudioAddict.**

---

Demo
--------------------------------------------------

![Demo](https://raw.githubusercontent.com/DannyBen/audio_addict/master/demo/demo.gif)


Install
--------------------------------------------------

Please note that in order to use this gem you need to have an AUdioAddict 
account (free or premium) at one of the AudioAddict networks.

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
  - [ZenRadio]
- View list of channels
- View currently playing track
- Vote on the currently playing track
- Save a log of a all your liked tracks
- Generate playlists (requires a premium account)


Usage
--------------------------------------------------

- Run the `radio` command to see a list of available subcommands.
- To see additional help, run `radio <subcommand> --help`

```
$ radio
AudioAddict Radio Utilities

Commands:
  login     Save login credentials
  set       Set the radio network and channel
  channels  Show list of channels
  now       Show network, channel and playing track
  history   Show track history for the current channel
  vote      Vote on a recently played track
  playlist  Generate playlists
  config    Manage local configuration
  log       Manage local like log
  api       Make direct calls to the AudioAddict API

```

---

[AudioAddict Platform]: http://www.audioaddict.com
[Digitally Imported]: http://di.fm
[RockRadio]: http://www.rockradio.com
[RadioTunes]: http://www.radiotunes.com
[JazzRadio]: http://www.jazzradio.com
[ClassicalRadio]: http://www.classicalradio.com
[ZenRadio]: http://www.zenradio.com
