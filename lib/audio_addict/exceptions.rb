module AudioAddict
  class APIError < StandardError
    attr_reader :response

    def initialize(response)
      @response = response
      super "#{response.code} #{response.message}: #{response.body}"
    end
  end
end