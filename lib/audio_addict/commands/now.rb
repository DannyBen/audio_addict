module AudioAddict
  module Commands
    class NowCmd < Base
      summary "Show network, channel and playing track"

      help "This command displays the active network and channel, as well as the currently playing track."

      usage "radio now"
      usage "radio now --help"

      def run
        needs :network, :channel

        say "!txtblu!  Network !txtrst!: !txtgrn!#{radio.name}!txtrst! # #{radio.network}"
        say "!txtblu!  Channel !txtrst!: !txtgrn!#{current_channel.name}!txtrst! # #{current_channel.key}"
        say "!txtblu!    Track !txtrst!: ... "

        track = current_channel.current_track
        resay "!txtblu!    Track !txtrst!: !txtgrn!#{track.title.strip}"
        say "!txtblu!       By !txtrst!: !txtgrn!#{track.artist.strip}"
      end
    end
  end
end
