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
        needs :session_key

        network = args['NETWORK']
        channel = args['CHANNEL']

        if !network or !Radio.valid_network? network
          interactive_menu network

        elsif Radio.valid_network? network
          save network

        end

        ChannelCmd.new.run("CHANNEL" => channel)
      end

    private

      def save(network, echo: true)
        Config.network = network
        Config.save
        say "Network : !txtgrn!#{radio.name}!txtrst! # #{network}" unless @interactive_menu_user
      end

      def interactive_menu(network = nil)
        list = Radio.networks network

        if list.count == 1
          save list.keys.first
        else
          answer = get_user_input list
          save(answer, echo: false) unless answer == :abort
        end
      end

      def get_user_input(networks)
        options = networks.invert
        options["Abort"] = :abort
        prompt.select "Network :", options, marker: '>', filter: true
      end

    end
  end
end