module AudioAddict
  class Radio
    include Cache
    include Inspectable

    attr_reader :network

    NETWORKS = {
      di:             'Digitally Imported',
      rockradio:      'Rock Radio',
      radiotunes:     'Radio Tunes',
      jazzradio:      'Jazz Radio',
      classicalradio: 'Classical Radio',
      zenradio:       'Zen Radio',
    }

    DOMAINS = {
      di:             'di.fm',
      rockradio:      'rockradio.com',
      radiotunes:     'radiotunes.com',
      jazzradio:      'jazzradio.com',
      classicalradio: 'classicalradio.com',
      zenradio:       'zenradio.com',
    }

    def self.networks(search = nil)
      if search
        result = NETWORKS.select { |k, v| "#{k} #{v}".downcase.include? search.downcase }
        result.any? ? result : NETWORKS
      else
        NETWORKS
      end
    end

    def self.valid_network?(network)
      NETWORKS.has_key?(network.to_sym)
    end

    def initialize(network)
      @network = network.to_sym
    end

    def inspectable
      [:network]
    end

    def name
      NETWORKS[network]
    end

    def domain
      DOMAINS[network]
    end

    def url_template
      channel_path = network == :zenradio ? 'zr%{channel_key}' : '%{channel_key}'
      "http://prem2.#{domain}:80/#{channel_path}?%{listen_key}"
    end

    def channels
      @channels ||= channels!
    end

    def search(query)
      channels.select do |key, channel|
        "#{key} #{channel.name.downcase}".include? query.downcase
      end
    end

    def search_by_id(ids)
      ids = [ids] unless ids.is_a? Array
      channels.select { |_key, channel| ids.include? channel.id }
    end

    def [](channel_key)
      channels[channel_key]
    end

    def valid_channel?(channel)
      channels.has_key?(channel)
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
        key = channel['key']
        candidate = Channel.new self, channel
        result[key] = candidate if candidate.active?
      end
      result.sort_by { |_key, channel| channel.name }.to_h
    end
  end
end
