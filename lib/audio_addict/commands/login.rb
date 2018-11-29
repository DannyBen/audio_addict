module AudioAddict
  module Commands
    class LoginCmd < Base
      summary "Save login credentials"

      help "Get a session key from AudioAddict API. This operation should only be done once."

      usage "radio login"
      usage "radio login --help"

      def run(args)
        if radio.api.logged_in?
          say "!txtylw!You are already logged in"
          proceed = prompt.yes? "Continue anyway?"
          abort unless proceed
        end

        user = prompt.ask "Username :"
        pass = prompt.ask "Password :", echo: false
        
        if user and pass
          say "Logging in... "
          radio.api.login user, pass
          resay "!txtgrn!Saved"
        else
          say "!txtred!Not saved"
        end
      end
    end
  end
end