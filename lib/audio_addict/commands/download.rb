module AudioAddict
  module Commands
    class DownloadCmd < Base
      summary "Download songs from YouTube"

      help "This command uses youtube-dl to download the currently playing song, or songs from your like-log."

      usage "radio download current [--count N]"
      usage "radio download log [--lines N --count N]"
      usage "radio download search QUERY [--count N]"
      usage "radio download --help"

      option "-l --lines N", "Number of log lines to download [default: 1]"
      option "-c --count N", "Number of YouTube search results to download [default: 1]"

      param "QUERY", "YouTube search query"

      command "current", "Download the currently playing song"
      command "log", "Download the last N songs from the like-log"
      command "search", "Download any song matching the Youtube search query"

      example "radio download current"
      example "radio download current --count 3"
      example "radio download log --lines 2 --count 3"
      example "radio download search 'Brimstone, Bright Shadow' -c2"

      def current_command
        needs :network, :channel
        count = args['--count']

        say "!txtblu!Current Track !txtrst!: ... "

        track = current_channel.current_track
        query = track.search_string

        resay "!txtblu!Downloading !txtgrn!: #{query}"

        Youtube.new(query).get count
      end

      def log_command
        needs :like_log
        count = args['--count']
        lines = args['--lines']&.to_i

        data = log.data[-lines..-1]
        data.each do |line|
          network, channel, artist, song = line.split(" :: ")
          query = "#{artist}, #{song}"
          say "\n!txtblu!Downloading !txtgrn!: #{query}"
          Youtube.new(query).get count
        end
      end

      def search_command
        query = args['QUERY']
        count = args['--count']

        say "\n!txtblu!Downloading !txtgrn!: #{query}"
        Youtube.new(query).get count
      end

    private

      def log
        @log ||= Log.new
      end
    end
  end
end
