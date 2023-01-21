module AudioAddict
  module Commands
    class NowCmd < Base
      summary 'Show network, channel and playing track'

      help 'This command displays the active network and channel, as well as the currently playing track.'

      usage 'radio now'
      usage 'radio now --help'

      def run
        needs :network, :channel

        say "b`  Network `: g`#{radio.name}` # #{radio.network}"
        say "b`  Channel `: g`#{current_channel.name}` # #{current_channel.key}"
        say 'b`    Track `: ... '

        track = current_channel.current_track
        say "b`    Track `: g`#{track.title.strip}`", replace: true
        say "b`       By `: g`#{track.artist.strip}`"
      end
    end
  end
end
