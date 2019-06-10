module AudioAddict
  module Commands
    class VoteCmd < Base
      summary "Vote on a recently played track" 

      help "This command starts an interactive voting prompt for the currently playing track or for previously played tracks."

      usage "radio vote [--all --past]"
      usage "radio vote --help"

      option "-a --all", "Show all voting options"
      option "-p --past", "Vote on previously played tracks"

      example "radio vote"
      example "radio vote --all"
      example "radio vote --past"
      example "radio vote --all --past"
      example "radio vote -ap"

      def run
        needs :network, :channel, :session_key
        vote_mode == :now ? vote_now : vote_past
      end

    private

      def vote_past
        track = get_user_track
        unless track == :cancel
          vote = get_user_vote
          send_vote vote, track unless vote == :cancel
        end
      end

      def vote_now
        NowCmd.new(args).run
        puts ""
        vote = get_user_vote
        send_vote vote unless vote == :cancel
      end

      def send_vote(vote, track = nil)
        say "Voting... "
        current_channel.vote vote, track: track
        resay "!txtgrn!Voted"
      end

      def tracks
        @tracks ||= current_channel.track_history
      end

      def max_artist_len
        tracks.map { |t| t.artist.size }.max
      end

      def get_user_track
        options = tracks.map { |t| ["#{t.artist.ljust max_artist_len} > #{t.title}", t]}.to_h
        options = { "Cancel" => :cancel }.merge options
        prompt.select "Track:", options, symbols: { marker: '>' }
      end

      def get_user_vote
        vote_style == :menu ? menu_prompt : simple_prompt
      end

      def menu_prompt
        options = { "Like" => :up, "Dislike" => :down, 
          "Unvote" => :delete, "Cancel" => :cancel }
        prompt.select "Vote:", options, symbols: { marker: '>' }
      end

      def simple_prompt
        like = prompt.yes? "Vote?"
        like ? :up : :cancel
      end

      def vote_style
        args['--all'] ? :menu : :simple
      end

      def vote_mode
        args['--past'] ? :past : :now
      end

    end
  end
end
