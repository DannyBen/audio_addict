require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

include AudioAddict
require_relative 'spec_mixin'
include SpecMixin

prepare_dummy_config

RSpec.configure do |c|
  c.include SpecMixin
  c.include Colsole
end
