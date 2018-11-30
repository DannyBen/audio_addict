require 'sinatra'
require 'byebug'

set :port, 3000
set :bind, '0.0.0.0'

def json(hash)
  JSON.pretty_generate hash
end

# Handshake
get '/' do
  json mockserver: :online
end

# Channels
get '/:network/channels' do
  response = [
    { id: 1, key: "trance",         name: "Trance",          asset_id: 1 },
    { id: 2, key: "dance",          name: "Dance",           asset_id: 2 },
    { id: 3, key: "ebm",            name: "EBM",             asset_id: 3 },
    { id: 4, key: "classictrance",  name: "Classic Trance",  asset_id: 4 },
  ]
  json response
end

# Tracks
get '/:network/track_history/channel/*' do
  response = [
    { track_id: 1, artist: "Dennis Sheperd", title: "Wanting (feat Molly Bancroft)" },
    { track_id: 2, artist: "D.Wingel",       title: "Alone in the Space" },
    { track_id: 3, artist: "Lulu Rouge",     title: "Sign Me Out" },
  ]
  json response
end

# Login
post '/:network/member_sessions' do
  response = {
    key: 'session-key-new',
    member: {
      listen_key: "listen-key-new"
    }
  }
  json response
end

# Vote
post '/:network/tracks/:track/vote/:channel/:direction' do
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

