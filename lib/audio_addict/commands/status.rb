module AudioAddict
  module Commands
    class StatusCmd < Base
      summary "Show configuration status"

      usage "radio status [--unsafe]"
      usage "radio status --help"

      option "-u --unsafe", "Show the full session and listen keys"

      def run(args)
        say "!txtblu! Config Path !txtrst!: !txtgrn!#{Config.path}"

        say "!txtblu! Session Key !txtrst!: "
        if Config.session_key
          key = Config.session_key
          display_key = args['--unsafe'] ? key : "***#{key[-4, 4]}"
          say "!txtgrn!#{display_key}"
        else 
          say "!txtred!<Unset>!txtrst! - run !txtpur!radio login!txtrst! to fix"
        end

        say "!txtblu!  Listen Key !txtrst!: "
        if Config.listen_key
          key = Config.listen_key
          display_key = args['--unsafe'] ? key : "***#{key[-4, 4]}"
          say "!txtgrn!#{display_key}"
        else 
          say "!txtred!<Unset>!txtrst! - run !txtpur!radio login!txtrst! to fix"
        end

        say "!txtblu!     Network !txtrst!: "
        if Config.network 
          say "!txtgrn!#{Config.network}"
        else
          say "!txtred!<Unset>!txtrst! - run !txtpur!radio set!txtrst! to fix"
        end

        say "!txtblu!     Channel !txtrst!: "
        if Config.channel
          say "!txtgrn!#{Config.channel}"
        else
          say"!txtred!<Unset>!txtrst! - run !txtpur!radio set!txtrst! to fix"
        end

      end
    end
  end
end