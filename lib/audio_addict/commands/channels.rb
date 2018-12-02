module AudioAddict
  module Commands
    class ChannelsCmd < Base
      summary "Show list of channels"

      help "List and search channels in the currently set radio network"

      usage "radio channels [SEARCH]"
      usage "radio channels --help"

      param "SEARCH", "Channel name or a partial name to search for"

      example "radio channels"
      example "radio channels metal"

      def run(args)
        needs :network

        say "!undgrn!#{radio.name}\n"

        search = args['SEARCH']

        channels = search ? radio.search(search) : radio.channels
        
        channels = channels.values
        channels.each do |channel|
          say "!txtgrn!#{channel.key.rjust 25} !txtblu!#{channel.name.strip}"
        end
      end
      
    end
  end
end