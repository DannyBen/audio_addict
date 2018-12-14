module AudioAddict
  module Commands
    class LoginCmd < Base
      summary "Save login credentials"

      help "Some commands in this AudioAddict CLI require access to the AudioAddict API. The 'login' command requests your AudioAddict user and password, and stores an API session key. This operation needs to be executed only once.\n\nThe user and password are not stored anywhere, only the session key is stored in your local configuration file."

      usage "radio login"
      usage "radio login --help"

      def run
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
          say "!txtred!Cancelled"
        end
      end
      
    end
  end
end