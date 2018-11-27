module AudioAddict
  module Commands
    class LoginCmd < Base
      summary "Save login credentials"

      help "Save the user and password in the config file."

      usage "radio login"
      usage "radio login --help"

      def run(args)
        say "!txtylw!Warning:!txtrst! Credentials will be stored unencrypted in\n!txtpur!#{Config.path}\n"
        user = prompt.ask "Username :"
        pass = prompt.ask "Password :", echo: false
        
        if user and pass
          Config.user = user
          Config.password = pass
          Config.save
          say "!txtgrn!Saved"
        else
          say "!txtred!Not saved"
        end
      end
    end
  end
end