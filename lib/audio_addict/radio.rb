module AudioAddict
  class Radio
    include Cache
    include Inspectable

    attr_reader :network

    NETWORKS = {
      di: "Digitally Imported",
      rockradio: "Rock Radio",
      radiotunes: "Radio Tunes",
      jazzradio: "Jazz Radio",
      classicalradio: "Classical Radio"
    }

    def self.valid_network?(network)
      NETWORKS.keys.include? network.to_sym
    end

    def initialize(network)
      @network = network
    end

    def inspectable
      [:network]
    end

    def name
      NETWORKS[network.to_sym]
    end

    def channels
      @channels ||= channels!
    end

    def [](channel_key)
      channels[channel_key]
    end

    def valid_channel?(channel)
      channels.keys.include? channel
    end

    def favorites
      api.member['network_favorite_channels']
    end

    def api
      @api ||= API.new network
    end

  private

    def channels!
      response = cache.get "#{network}/channels" do
        api.get 'channels'
      end

      result = {}
      response.map do |channel|
        result[channel['key']] = Channel.new self, channel
      end
      result
    end

  end
end
