lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'audio_addict/version'

Gem::Specification.new do |s|
  s.name        = 'audio_addict'
  s.version     = AudioAddict::VERSION
  s.summary     = 'AudioAddict Command Line'
  s.description = 'Command line for playlist management and voting for AudioAddict radio networks'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.executables = ['radio']
  s.homepage    = 'https://github.com/dannyben/audio_addict'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 3.1'

  s.add_dependency 'colsole', '~> 1.0.0'
  s.add_dependency 'httparty', '~> 0.21'
  s.add_dependency 'lightly', '~> 0.3'
  s.add_dependency 'mister_bin', '~> 0.7'
  s.add_dependency 'requires', '~> 1.0'
  s.add_dependency 'tty-prompt', '~> 0.19'

  # FIXME: These are needed since Ruby 3.4 will no longer bundle these, and the
  #        dependencies have not yet reflected this change, namely `httparty`
  #        and `multi_xml`. Remove when appropriate.
  s.add_dependency 'base64', '>= 0', '< 1'
  s.add_dependency 'bigdecimal', '>= 2', '< 4'
  s.add_dependency 'csv', '>= 2', '< 4'
  s.add_dependency 'json', '>= 1', '< 4'
  s.add_dependency 'logger', '>= 1', '< 3'
  s.add_dependency 'ostruct', '>= 0', '< 2'

  s.metadata = {
    'bug_tracker_uri'       => 'https://github.com/DannyBen/audio_addict/issues',
    'changelog_uri'         => 'https://github.com/DannyBen/audio_addict/blob/master/CHANGELOG.md',
    'source_code_uri'       => 'https://github.com/DannyBen/audio_addict',
    'rubygems_mfa_required' => 'true',
  }
end
