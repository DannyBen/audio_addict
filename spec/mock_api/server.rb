require 'sinatra'
require 'byebug'

set :port, 3000
set :bind, '0.0.0.0'

def json(hash)
  JSON.pretty_generate hash
end

get '/' do
  json mockserver: 'online'
end

get '*/channels' do
  response = [
    { id: 1, key: "trance",         name: "Trance",          asset_id: 1 },
    { id: 2, key: "dance",          name: "Dance",           asset_id: 2 },
    { id: 3, key: "ebm",            name: "EBM",             asset_id: 3 },
    { id: 4, key: "classictrance",  name: "Classic Trance",  asset_id: 4 },
  ]
  json response
end

get '*/track_history/channel/*' do
  response = [
    { artist: "Dennis Sheperd", title: "Wanting (feat Molly Bancroft)" },
    { artist: "D.Wingel",       title: "Alone in the Space" },
    { artist: "Lulu Rouge",     title: "Sign Me Out" },
  ]
  json response
end

post '*/member_sessions' do
  response = {
    key: 'session-key-new',
    member: {
      listen_key: "listen-key-new"
    }
  }
  json response
end

get '*' do
  path = params['splat'].first
  halt 500, "The path '#{path}' is not implemented in the mock api"
end
