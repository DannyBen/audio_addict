module AudioAddict
  module Commands
    class VoteCmd < Base
      summary "Vote on the currently playing track" 

      help "Start an interactive voting prompt for the currently playing track."

      usage "radio vote"
      usage "radio vote --help"

      def run(args)
        NowCmd.new.run args
        answer = get_user_vote
        exit if answer == :abort

        say "Voting... "
        current_channel.vote answer
        resay "Voted"
      end

    private

      def get_user_vote
        options = { "Like" => :up, "Dislike" => :down, 
          "Unvote" => :delete, "Abort" => :abort }
        prompt.select "Your Vote :", options, marker: '>'
      end

    end
  end
end