module AudioAddict
  module Commands
    class LoginCmd < Base
      summary "Save login credentials"

      help "Get a session key from AudioAddict API. This operation should only be done once."

      usage "radio login"
      usage "radio login --help"

      def run(args)
        proceed = true

        if radio.api.logged_in?
          say "!txtylw!You are already logged in as !undylw!#{Config.email}"
          proceed = prompt.yes? "Login again?"
        end
        
        login_prompt if proceed
      end

    private

      def login_prompt
        user = prompt.ask "Username :", default: Config.email
        pass = prompt.mask "Password :"
        
        if user and pass
          say "Logging in... "
          radio.api.login user, pass
          resay "!txtgrn!Saved"
        else
          say "!txtred!Aborted"
        end
      end
      
    end
  end
end