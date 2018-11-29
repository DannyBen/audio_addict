module AudioAddict
  module Commands
    class SetCmd < Base
      summary "Set the radio network and channel"

      help "Save the network and optionally the channel to the config file for future use"

      usage "radio set [NETWORK CHANNEL]"
      usage "radio set --help"

      param "NETWORK", "AudioAddict network key. Leave empty for an interactive prompt."
      param "CHANNEL", "AudioAddict channel key. You can use a partial key here or leave empty for an interactive prompt."

      example "radio set"
      example "radio set rockradio"
      example "radio set rockradio modern"
      example "radio set rockradio modernrock"

      def run(args)
        network = args['NETWORK']
        channel = args['CHANNEL']

        proceed = true

        if !network or !Radio.valid_network? network
          network = get_user_input network
          proceed = false if network == :abort
        end

        handle network, channel if proceed
      end

    private

      def handle(network, channel)
        save network
        ChannelCmd.new.run("CHANNEL" => channel)
      end

      def save(network)
        Config.network = network
        Config.save
        say "Network : !txtgrn!#{radio.name}!txtrst! # #{network}" unless @interactive_menu_user
      end

      def get_user_input(network)
        list = Radio.networks network

        if list.count == 1
          list.keys.first
        else
          @interactive_menu_used = true
          options = list.invert
          options["Abort"] = :abort
          prompt.select "Network :", options, marker: '>', filter: true
        end
      end

    end
  end
end