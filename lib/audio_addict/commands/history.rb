module AudioAddict
  module Commands
    class HistoryCmd < Base
      summary "Show track history for the current channel" 

      usage "radio history"
      usage "radio history --help"

      def run(args)
        needs :network, :channel
        say "!undgrn!#{radio.name} > #{current_channel.name}"
        say ''
        tracks.each do |channel|
          say "!txtgrn! #{channel.artist.rjust max_artist_len}!txtrst! : !txtblu!#{channel.title}"
        end
      end

    private

      def tracks
        @tracks ||= current_channel.track_history
      end

      def max_artist_len
        tracks.map { |t| t.artist.size }.max
      end
    end
  end
end