module AudioAddict
  module Commands
    class HistoryCmd < Base
      summary 'Show track history for the current channel'

      help 'This command shows the last few tracks that were playing on the currently active channel in reverse order (top track is the most recent).'

      usage 'radio history'
      usage 'radio history --help'

      def run
        needs :network, :channel
        say "gu`#{radio.name} > #{current_channel.name}`"
        say ''
        tracks.each do |track|
          say "g` #{track.artist.rjust max_artist_len}` : b`#{track.title}`"
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
