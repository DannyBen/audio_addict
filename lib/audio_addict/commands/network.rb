module AudioAddict
  module Commands
    class NetworkCmd < Base
      summary "Set the radio network"

      help "Save the network to the config file for future use"

      usage "radio network [NETWORK CHANNEL]"
      usage "radio network --help"

      param "NETWORK", "AudioAddict network key. Leave empty for an interactive prompt."
      param "CHANNEL", "AudioAddict channel key. You can use a partial key here for an interactive prompt, or leave empty to only set the network.\nIf left empty, you might need to run the channel command to set the channel separately."

      example "radio network"
      example "radio network rockradio"
      example "radio network rockradio modern"
      example "radio network rockradio modernrock"

      def run(args)
        network = args['NETWORK']
        channel = args['CHANNEL']

        proceed = true

        if !network or !Radio.valid_network? network
          say "Invalid network !txtred!#{network}!txtrst!.\n" if network
          network = get_user_input
          proceed = false if network == :abort
        end

        handle network, channel if proceed
      end

    private

      def handle(network, channel)
        last_stored_network = Config.network

        if network == last_stored_network
          say "Network Unchanged"

        else
          save network
          if channel        
            ChannelCmd.new.run("CHANNEL" => channel)

          else
            Config.channel = nil
            Config.save
            say "Run !txtpur!radio channel!txtrst! to set the channel"

          end
        end
      end

      def save(network)
        Config.network = network
        Config.save
        say "Saved Network: !txtgrn!#{radio.name}!txtrst! # #{network}"
      end

      def get_user_input
        options = Radio::NETWORKS.invert
        options["Abort"] = :abort
        prompt.select "Choose a Network :", options, marker: '>'
      end

    end
  end
end