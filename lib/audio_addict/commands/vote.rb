module AudioAddict
  module Commands
    class VoteCmd < Base
      summary "Vote on the currently playing track" 

      help "Start an interactive voting prompt for the currently playing track."

      usage "radio vote"
      usage "radio vote --help"

      def run(args)
        needs :network, :channel, :session_key

        NowCmd.new.run args
        puts ""
        answer = get_user_vote
        unless answer == :abort
          say "Voting... "
          current_channel.vote answer
          resay "!txtgrn!Voted"
        end
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