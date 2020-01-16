require "requires"
require "byebug" if ENV["BYEBUG"]
requires \
  "audio_addict/exceptions",
  "audio_addict/cache",
  "audio_addict/inspectable",
  "audio_addict/auto_properties",
  "audio_addict/commands/base",
  "audio_addict"
