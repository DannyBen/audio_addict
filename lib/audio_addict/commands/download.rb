module AudioAddict
  module Commands
    class DownloadCmd < Base
      summary 'Download songs from YouTube'

      help 'This command uses youtube-dl to download the currently playing song, or songs from your like-log.'

      usage 'radio download current [--count N]'
      usage 'radio download log [--lines N --count N]'
      usage 'radio download search QUERY [--count N]'
      usage 'radio download --help'

      option '-l --lines N', 'Number of log lines to download [default: 1]'
      option '-c --count N',
        "Number of YouTube search results to download\nDefaults to the value of the AUDIO_ADDICT_DOWNLOAD_COUNT environment variable, or 1"

      param 'QUERY', 'YouTube search query'

      command 'current', 'Download the currently playing song'
      command 'log', 'Download the last N songs from the like-log'
      command 'search', 'Download any song matching the Youtube search query'

      environment 'AUDIO_ADDICT_DOWNLOAD_COUNT', 'Set the default download count (--count)'

      example 'radio download current'
      example 'radio download current --count 3'
      example 'radio download log --lines 2 --count 3'
      example "radio download search 'Brimstone, Bright Shadow' -c2"

      def current_command
        needs :network, :channel

        say 'b`Downloading` : ... '

        track = current_channel.current_track
        query = track.search_string

        say "b`Downloading` : g`#{query}`", replace: true

        Youtube.new(query).get count
      end

      def log_command
        needs :like_log
        lines = args['--lines']&.to_i

        data = log.data[-lines..]
        data.each do |line|
          _network, _channel, artist, song = line.split(' :: ')
          query = "#{artist}, #{song}"
          say "\nb`Downloading` : g`#{query}`"
          Youtube.new(query).get count
        end
      end

      def search_command
        query = args['QUERY']

        say "\nb`Downloading` : g`#{query}`"
        Youtube.new(query).get count
      end

    private

      def count
        args['--count']&.to_i || ENV['AUDIO_ADDICT_DOWNLOAD_COUNT']&.to_i || 1
      end

      def log
        @log ||= Log.new
      end
    end
  end
end
