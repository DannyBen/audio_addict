module AudioAddict
  class Radio
    include Cache
    include Inspectable

    attr_reader :user, :password, :network

    def initialize(network, user: nil, password: nil)
      @user, @password, @network = user, password, network
    end

    def inspectable
      [:network]
    end

    def channels
      @channels ||= channels!
    end

    def [](channel_key)
      channels[channel_key]
    end

    def member
      api.session['member']
    end

    def favorites
      member['network_favorite_channels']
    end

    def api
      @api ||= API.new network, user: user, password: password
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
