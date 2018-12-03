module AudioAddict
  module Commands
    class HistoryCmd < Base
      summary "Show track history for the current channel" 

      usage "radio history"
      usage "radio history --help"

      def run(args)
        needs :network, :channel

        tracks = current_channel.track_history
        max_artist_len = tracks.map { |t| t.artist.size }.max

        say "!undgrn!#{radio.name} > #{current_channel.name}"
        say ''
        current_channel.track_history.each do |channel|
          say "!txtgrn! #{channel.artist.rjust max_artist_len}!txtrst! : !txtblu!#{channel.title}"
        end
      end

    end
  end
end