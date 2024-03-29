module AudioAddict
  module Commands
    class APICmd < Base
      summary 'Make direct calls to the AudioAddict API'

      help 'This command sends a request to the provided API endpoint. The currently configured network is automatically prepended to the endpoint path, and the output is converted to YAML format.'

      usage 'radio api [get|post|delete] ENDPOINT'
      usage 'radio api --help'

      param 'ENDPOINT', 'API endpoint path'

      example 'radio api channels'
      example 'radio api get track_history/channel/1'
      example 'radio api post tracks/1/vote/2/up'

      def run
        needs :network
        response = api.send(api_method, endpoint)
        puts response.to_yaml
      end

    private

      def api_method
        return :post if args['post']
        return :delete if args['delete']

        :get
      end

      def endpoint
        args['ENDPOINT']
      end

      def api
        @api ||= API.new current_network
      end
    end
  end
end
