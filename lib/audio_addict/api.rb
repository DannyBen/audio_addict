require 'httparty'

module AudioAddict
  class API
    include HTTParty
    include Cache

    base_uri 'https://api.audioaddict.com/v1'

    attr_reader :user, :password, :network

    def initialize(network, user: nil, password: nil)
      @user, @password, @network = user, password, network
      
      if !user and !password and ENV['AUDIO_ADDICT_LOGIN']
        @user, @password = ENV['AUDIO_ADDICT_LOGIN'].split ':'
      end
    end

    def get(path)
      require_network
      response http.get "/#{network}/#{path}", http_opts
    end

    def post(path)
      require_network
      response http.post "/#{network}/#{path}", http_opts
    end

    def logged_in?
      user and password and session_key
    end

    def session
      cache.get "/#{network}/member_sessions" do
        http.basic_auth 'streams', 'diradio'
        response http.post("/#{network}/member_sessions", body: member_session_params)
      end
    end

  private

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

    def http_opts
      { headers: headers }
    end

    def headers
      { "X-Session-Key" => session_key }
    end

    def session_key
      session['key']
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

  end
end
