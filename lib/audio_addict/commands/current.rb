module AudioAddict
  module Commands
    class CurrentCmd < Base
      summary "Show network, channel and playing track" 

      help "Display the configured network and channel, as well as the currently playing track."

      usage "radio current"
      usage "radio current --help"

      def run(args)
        say "!txtblu!  Network !txtrst!: !txtgrn!#{current_network}"
        say "!txtblu!  Channel !txtrst!: !txtgrn!#{current_channel.name}!txtrst! (#{current_channel.key})"

        track = current_channel.current_track
        say "!txtblu!    Track !txtrst!: !txtgrn!#{track.title.strip}"
        say "!txtblu!       By !txtrst!: !txtgrn!#{track.artist.strip}"
      end

    end
  end
end