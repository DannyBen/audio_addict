require "httparty"

module AudioAddict
  class API
    include HTTParty
    include Cache

    base_uri "https://api.audioaddict.com/v1"

    attr_accessor :network

    def initialize(network)
      @network = network
    end

    def login(username, password)
      session = session(username, password)
      Config.session_key = session["key"]
      Config.listen_key = session["member"]["listen_key"]
      Config.email = session["member"]["email"]
      Config.premium = session["member"]["user_type"] == "premium"
      Config.save
    end

    def get(path, args = {})
      response http.get "/#{network}/#{path}", headers: headers, body: args
    end

    def post(path, args = {})
      response http.post "/#{network}/#{path}", headers: headers, body: args
    end

    def delete(path, args = {})
      response http.delete "/#{network}/#{path}", headers: headers, body: args
    end

    def logged_in?
      session_key and listen_key
    end

    def basic_auth
      http.basic_auth "streams", "diradio"
    end

    def session(username, password)
      params = { member_session: { username: username, password: password } }
      basic_auth
      response http.post "/#{network || "di"}/member_sessions", body: params
    end

    def session_key
      Config.session_key
    end

    def listen_key
      Config.listen_key
    end

    private

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
  end
end
