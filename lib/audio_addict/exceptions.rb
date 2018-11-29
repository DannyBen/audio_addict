module AudioAddict
  class Error < StandardError; end
  
  class Interrupt < Error; end
  class ArgumentError < Error; end
  class ConfigError < Error; end
  
  class LoginError < Error
    def initialize(msg="This operation requires logging in")
      super
    end
  end

  class APIError < Error
    attr_reader :response

    def initialize(response)
      @response = response
      super "#{response.code} #{response.message}:\n#{response.body}"
    end
  end
end