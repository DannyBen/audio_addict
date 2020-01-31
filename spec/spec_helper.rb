require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

include AudioAddict
require_relative 'spec_mixin'
include SpecMixin

# Consistent Colsole output (for rspec_fixtures)
ENV['TTY'] = 'off'

reset_config

Dir.mkdir 'spec/tmp' unless Dir.exist? 'spec/tmp'

RSpec.configure do |c|
  c.include SpecMixin
  c.include Colsole

  c.strip_ansi_escape = true

  c.before :suite do
    AudioAddict::API.base_uri "http://localhost:3000"
  end
end
