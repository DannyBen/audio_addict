module AudioAddict
  module Commands
    class SetCmd < Base
      summary "Configure the radio network and channel"

      help "Save the channel and optionally the network to the config file for future use"

      usage "radio set CHANNEL [NETWORK]"
      usage "radio set --help"

      param "NETWORK", "AudioAddict network key. Can be one of:\ndi, rockradio, radiotunes, jazzradio or classicalradio."
      param "CHANNEL", "AudioAddict channel key."

      example "radio set modernrock rockradio"
      example "radio set modernrock"

      def run(args)
        network = args['NETWORK']
        channel = args['CHANNEL']

        if network
          if !Radio.valid_network? network
            say "Invalid network !txtred!#{network}!txtrst!. Valid options are:\n"
            Radio::NETWORKS.each do |key, name|
              say "!txtblu! #{key.to_s.rjust 20} : !txtgrn!#{name}"
            end
            exit 1
          end

          Config.network = network
          @radio = nil
        end

        if radio.valid_channel? channel
          Config.channel = channel
          Config.save
          say "Saved to !txtpur!#{Config.path}"
        
        else
          say "Invalid channel !txtred!#{channel}!txtrst! in !txtgrn!#{radio.name}!txtrst!."
          say "Run !txtpur!radio channels!txtrst! for a list of available channels."

        end
      end
    end
  end
end