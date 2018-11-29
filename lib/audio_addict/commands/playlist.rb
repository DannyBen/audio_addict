module AudioAddict
  module Commands
    class PlaylistCmd < Base
      summary "Generate playlists" 

      usage "radio playlist init"
      usage "radio playlist generate"
      usage "radio playlist --help"

      command "init", "Create a playlist configuration file. This step is required prior to using the generate command."
      command "generate", "Generate a playlist file based on the configuration file."

      def run(args)
        @args = args
        needs :network, :channel

        init if args['init']
        generate if args['generate']
      end

    private

      def init
        p radio.channels
      end

      def generate
      end

    end
  end
end