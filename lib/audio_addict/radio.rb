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

    DOMAINS = {
      di: "di.fm",
      rockradio: "rockradio.com",
      radiotunes: "radiotunes.com",
      jazzradio: "jazzradio.com",
      classicalradio: "classicalradio.com"
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

    def domain
      DOMAINS[network.to_sym]
    end

    def channels
      @channels ||= channels!
    end

    def search(query)
      channels.select do |key, channel|
        "#{key} #{channel.name.downcase}".include? query.downcase
      end 
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

      # Debug
      # File.write 'out.yml', response.to_yaml

      result = {}
      response.map do |channel|
        key = channel['key']
        candidate = Channel.new self, channel
        result[key] = candidate if candidate.active?
      end
      result.sort_by { |key, channel| channel.name }.to_h
    end
  end
end
