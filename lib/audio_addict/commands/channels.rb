module AudioAddict
  module Commands
    class ChannelsCmd < Base
      summary 'Show list of channels'

      help 'This command lets you list and search for channels in the currently active radio network.'

      usage 'radio channels [SEARCH --info]'
      usage 'radio channels --help'

      option '-i --info', 'Show results with additional info, such as channel description and related channels'

      param 'SEARCH', 'Channel name or a partial name to search for'

      example 'radio channels'
      example 'radio channels --info'
      example 'radio channels metal'
      example 'radio channels metal -i'

      def run
        needs :network

        say "gu`#{radio.name}`\n"

        search = args['SEARCH']

        channels = search ? radio.search(search) : radio.channels

        channels = channels.values
        if args['--info']
          show_verbose channels
        else
          show_compact channels
        end
      end

    private

      def show_verbose(channels)
        channels.each do |channel|
          say ''
          say "g`#{channel.name.ljust 22} `# #{channel.key}"
          say ''
          say word_wrap channel.description.to_s
          say ''

          similar = channel.similar_channels

          next unless similar.any?

          say 'Similar Channels:'
          similar.each do |key, similar_channel|
            say "- b`#{similar_channel.name.ljust 20}` # #{key}"
          end
          say ''
        end
      end

      def show_compact(channels)
        channels.each do |channel|
          say "b`#{channel.key.rjust 25}` g`#{channel.name.strip}`"
        end
      end
    end
  end
end
