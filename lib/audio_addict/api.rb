require 'httparty'

module AudioAddict
  class API
    include HTTParty
    include Cache

    base_uri 'https://api.audioaddict.com/v1'

    attr_accessor :network
    attr_writer :user, :password

    def initialize(network, user: nil, password: nil)
      @user, @password, @network = user, password, network
    end

    def get(path)
      response http.get "/#{network}/#{path}", http_opts
    end

    def post(path)
      response http.post "/#{network}/#{path}", http_opts
    end

    def delete(path)
      response http.delete "/#{network}/#{path}", http_opts
    end

    def user
      @user ||= Config.user
    end

    def password
      @password ||= Config.password
    end

    def logged_in?
      user and password and session_key
    end

    def member
      session['member']
    end

    def session
      cache.get "/#{network}/member_sessions" do
        http.basic_auth 'streams', 'diradio'
        response http.post("/#{network}/member_sessions", body: member_session_params)
      end
    end

    def session_key
      session['key']
    end

  private

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

    def member_session_params
      raise LoginError unless user and password
      { member_session: { username: user, password: password } }
    end

  end
end
