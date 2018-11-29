module AudioAddict
  module Commands
    class NetworkCmd < Base
      summary "Set the radio network"

      help "Save the network to the config file for future use"

      usage "radio network [NETWORK]"
      usage "radio network --help"

      param "NETWORK", "AudioAddict network key. Leave empty for an interactive prompt."

      example "radio network"
      example "radio network rockradio"

      def run(args)
        network = args['NETWORK']

        if !network or !Radio.valid_network? network
          say "Invalid network !txtred!#{network}!txtrst!.\n" if network
          network = get_user_input

          unless network == :abort
            Config.network = network
            Config.save
            say "!txtgrn!Saved"
          end
        end
      end

    private

      def get_user_input
        options = Radio::NETWORKS.invert
        options["Abort"] = :abort
        prompt.select "Choose a Network :", options, marker: '>'
      end

    end
  end
end