module AudioAddict
  module Commands
    class StatusCmd < Base
      summary "Show configuration status"

      usage "radio status"
      usage "radio status --help"

      def run(args)
        say "!txtblu! Config Path !txtrst!: !txtgrn!#{Config.path}"

        say "!txtblu!    Username !txtrst!: "
        say Config.user ? "!txtgrn!#{Config.user}" : "!txtred!<Unset>"

        say "!txtblu!    Password !txtrst!: "
        say Config.password ? "!txtgrn!<Set>" : "!txtred!<Unset>"

        say "!txtblu!     Network !txtrst!: "
        say Config.network ? "!txtgrn!#{Config.network}" : "!txtred!<Unset>"

        say "!txtblu!     Channel !txtrst!: "
        say Config.channel ? "!txtgrn!#{Config.channel}" : "!txtred!<Unset>"

        say "!txtblu! Session Key !txtrst!: "
        
        if Config.network
          session = API.new(Config.network).session_key
          say "!txtgrn!#{session}"
        else
          say "!txtred!<Unset>"
        end        
      end
    end
  end
end