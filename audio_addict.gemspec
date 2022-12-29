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
  s.required_ruby_version = '>= 2.6.0'

  s.add_runtime_dependency 'colsole', '~> 0.5'
  s.add_runtime_dependency 'httparty', '~> 0.16'
  s.add_runtime_dependency 'lightly', '~> 0.3'
  s.add_runtime_dependency 'mister_bin', '~> 0.7.3'
  s.add_runtime_dependency 'requires', '~> 1.0'
  s.add_runtime_dependency 'tty-prompt', '~> 0.19'

  s.metadata['rubygems_mfa_required'] = 'true'
end
