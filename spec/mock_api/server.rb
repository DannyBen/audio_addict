require 'sinatra'
require 'byebug'
require 'yaml'

set :port, 3000
set :bind, '0.0.0.0'

def json(hash)
  JSON.pretty_generate hash
end

def config
  @config ||= YAML.load_file(config_file)
end

def config_file
  File.expand_path 'config.yml', __dir__
end

# Handshake
get '/' do
  json mockserver: :online
end

# Channels
get '/:network/channels' do
  json config[:channels]
end

# Tracks
get '/:network/track_history/channel/*' do
  json config[:track_history]
end

# Login
post '/:network/member_sessions' do
  json config[:login]
end

# Vote
post '/:network/tracks/:track/vote/:channel/:direction' do
  json vote: :success
end

delete '/:network/tracks/:track/vote/:channel' do
  json vote: :success
end

# Not Implemented
get '*' do
  path = params['splat'].first
  halt 500, "GET #{path} : not implemented"
end

post '*' do
  path = params['splat'].first
  halt 500, "POST #{path} : not implemented"
end

delete '*' do
  path = params['splat'].first
  halt 500, "DELETE #{path} : not implemented"
end

