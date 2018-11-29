module AudioAddict
  module Commands
    class StatusCmd < Base
      summary "Show configuration status"

      usage "radio status"
      usage "radio status --help"

      def run(args)
        say "!txtblu! Config Path !txtrst!: !txtgrn!#{Config.path}"

        say "!txtblu! Session Key !txtrst!: "
        say Config.session_key ? "!txtgrn!#{Config.session_key}" : "!txtred!<Unset>"

        say "!txtblu!     Network !txtrst!: "
        say Config.network ? "!txtgrn!#{Config.network}" : "!txtred!<Unset>"

        say "!txtblu!     Channel !txtrst!: "
        say Config.channel ? "!txtgrn!#{Config.channel}" : "!txtred!<Unset>"

      end
    end
  end
end