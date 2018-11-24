require 'httparty'
require 'lightly'

module AudioAddict
  class API
    include HTTParty
    base_uri 'https://api.audioaddict.com/v1'

    attr_reader :user, :password, :network

    def initialize(network, user: nil, password: nil)
      @user, @password, @network = user, password, network
      
      if !user and !password and ENV['AUDIO_ADDICT_LOGIN']
        @user, @password = ENV['AUDIO_ADDICT_LOGIN'].split ':'
      end
    end

    # Returns a full eresponse of all channels
    def channels
      cache.get "/#{network}/channels" do
        response http.get "/#{network}/channels"
      end
    end

    # Returns the channel ID based on a key
    def channel_id(channel_key)
      results = channels.select { |c| c['key'] == channel_key}
      results.any? ? results.first['id'] : nil
    end

    # Returns a channel history of all channels, or the given channel
    def track_history(channel_id = nil)
      endpoint = "/#{network}/track_history"
      endpoint = "#{endpoint}/channel/#{channel_id}" if channel_id 
      response http.get endpoint
    end

    # Returns the last played track in a channel
    def last_track(channel_id)
      track_history(channel_id).first
    end

    # Vote up or down on a given track or channel.
    # - If you provide channel only, the last track is voted on
    # - If you provide track only, it is voted without channel context
    # - If you provide both, the track is voted in the channel context
    def vote(channel_id: nil, track_id: nil, direction: :up)
      raise ArgumentError, "Either 'channel_id' or 'track_id' must be provided" if !channel_id and !track_id

      require_login

      if track_id and !channel_id
        endpoint = "/#{network}/tracks/#{track_id}/vote/#{direction}"

      elsif channel_id and !track_id
        track_id = last_track(channel_id)['track_id']
        endpoint = "/#{network}/tracks/#{track_id}/vote/#{channel_id}/#{direction}"

      else
        endpoint = "/#{network}/tracks/#{track_id}/vote/#{channel_id}/#{direction}"

      end

      response http.post(endpoint, headers: headers)
    end

    def logged_in?
      user and password and session_key
    end

  private

    def require_login
      raise ArgumentError, "Login required" unless logged_in?
    end

    def require_network
      raise ArgumentError, "No network specified" unless network
    end

    def response(httparty_response)
      raise APIError.new httparty_response unless httparty_response.success?
      JSON.parse httparty_response.body
    end

    def http
      @http ||= self.class
    end

    def headers
      { "X-Session-Key" => session_key }
    end

    def member_session_params
      raise ArgumentError, "Please provide login credentials" if !user or !password

      {
        member_session: {
          username: user,
          password: password,
        }
      }
    end

    def session_key
      session['key']
    end

    def session
      cache.get "/#{network}/member_sessions" do
        http.basic_auth 'streams', 'diradio'
        response http.post("/#{network}/member_sessions", body: member_session_params)
      end
    end

    def cache
      @cache ||= cache!
    end

    def cache!
      cache_dir = ENV['AUDIO_ADDICT_CACHE_DIR'] || "#{Dir.home}/tmp/audio_addict_cache"
      @cache ||= Lightly.new life: '6h', dir: cache_dir
    end
  end
end
