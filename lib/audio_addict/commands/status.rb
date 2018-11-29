module AudioAddict
  module Commands
    class StatusCmd < Base
      summary "Show configuration status"

      usage "radio status [--session]"
      usage "radio status --help"

      option "-s --session", "Show the full session key"

      def run(args)
        say "!txtblu! Config Path !txtrst!: !txtgrn!#{Config.path}"

        say "!txtblu! Session Key !txtrst!: "
        if Config.session_key
          session_key = Config.session_key
          display_key = args['--session'] ? session_key : "***#{session_key[-4, 4]}"
          say "!txtgrn!#{display_key}"
        else 
          say "!txtred!<Unset>!txtrst! - run !txtpur!radio login!txtrst! to fix"
        end

        say "!txtblu!     Network !txtrst!: "
        if Config.network 
          say "!txtgrn!#{Config.network}"
        else
          say "!txtred!<Unset>!txtrst! - run !txtpur!radio network!txtrst! to fix"
        end

        say "!txtblu!     Channel !txtrst!: "
        if Config.channel
          say "!txtgrn!#{Config.channel}"
        else
          say"!txtred!<Unset>!txtrst! - run !txtpur!radio channel!txtrst! to fix"
        end

      end
    end
  end
end