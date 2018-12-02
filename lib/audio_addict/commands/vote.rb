module AudioAddict
  module Commands
    class VoteCmd < Base
      summary "Vote on the currently playing track" 

      help "Start an interactive voting prompt for the currently playing track."

      usage "radio vote [--all]"
      usage "radio vote --help"

      option "-a --all", "Show all voting options"

      def run(args)
        needs :network, :channel, :session_key

        prompt_style = args['--all'] ? :menu : :simple

        NowCmd.new.run args
        puts ""
        answer = get_user_vote style: prompt_style
        unless answer == :cancel
          say "Voting... "
          current_channel.vote answer
          resay "!txtgrn!Voted"
        end
      end

    private

      def get_user_vote(style: :menu)
        if style == :menu
          menu_prompt
        else
          simple_prompt
        end
      end

      def menu_prompt
        options = { "Like" => :up, "Dislike" => :down, 
          "Unvote" => :delete, "Cancel" => :cancel }
        prompt.select "Your Vote :", options, marker: '>'
      end

      def simple_prompt
        like = prompt.yes? "Like?"
        like ? :up : :cancel
      end

    end
  end
end