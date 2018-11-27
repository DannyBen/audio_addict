module AudioAddict
  module Commands
    class ChannelCmd < Base
      summary "Set the radio channel"

      help "Save the channel to the config file for future use"

      usage "radio channel CHANNEL"
      usage "radio channel --help"

      param "CHANNEL", "AudioAddict channel key."

      example "radio channel rockradio"

      def run(args)
        channel = args['CHANNEL']

        if radio.valid_channel? channel
          Config.channel = channel
          Config.save
          say "Saved to !txtpur!#{Config.path}"
        
        else
          say "!txtred!Invalid channel: #{radio.name} > #{channel}"
          say "Run !txtpur!radio channels!txtrst! for a list of available channels"

        end
      end
    end
  end
end