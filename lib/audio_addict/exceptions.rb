module AudioAddict
  class Error < StandardError; end
  
  class Interrupt < Error; end

  class ArgumentError < Error; end

  class ConfigError < Error
    attr_reader :missing_keys

    def initialize(missing_keys)
      @missing_keys = missing_keys
      super "Some parameters required by this operation are missing" 
    end
  end
  
  class PremiumAccount < Error
    def initialize(message="This operation requires a premium account")
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