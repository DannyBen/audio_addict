module AudioAddict
  module Commands
    class ChannelsCmd < Base
      summary "Show list of channels"

      help "List and search channels in the currently set radio network"

      usage "radio channels [SEARCH]"
      usage "radio channels --help"

      param "SEARCH", "Channel name or a partial name to search for."

      example "radio channels"
      example "radio channels metal"

      def run(args)
        search = args['SEARCH']
        channels = radio.channels.values

        if search
          channels.select! { |c| "#{c.key} #{c.name.downcase}".include? search.downcase } 
        end
        
        channels.each do |channel|
          say "!txtgrn!#{channel.key.rjust 25} !txtblu!#{channel.name.strip}"
        end
      end
      
    end
  end
end