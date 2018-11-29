module AudioAddict
  module Commands
    class SetupCmd < Base
      summary "Set all required config values at once"

      help "This is a shortcut to running the login, network and channel commands."

      usage "radio setup"
      usage "radio setup --help"

      def run(args)
        @args = args

        proceed = true
        
        if Config.valid?
          say "!txtylw!Your configuration file seems to be valid"
          proceed = prompt.yes? "Continue with setup anyway?"
        end

        run_setup if proceed
      end

    private

      def run_setup
        say "\n!undgrn!Login\n"
        LoginCmd.new.run @args

        say "\n!undgrn!Network\n"
        NetworkCmd.new.run @args

        say "\n!undgrn!Channel\n"
        ChannelCmd.new.run @args
      end
    end
  end
end