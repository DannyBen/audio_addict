module AudioAddict
  class Client
    include Cache

    attr_reader :user, :password, :network

    def initialize(network, user: nil, password: nil)
      @user, @password, @network = user, password, network
    end

    def channels
      @channels ||= channels!
    end

    def track_history(channel_key)
      channel_id = channel_key_to_id channel_key
      api.get "track_history/channel/#{channel_id}"
    end

    def current_track(channel_key)
      track_history(channel_key).first
    end

    def vote(channel_key, direction = :up)
      channel_id = channel_key_to_id channel_key
      track_id = current_track(channel_key)['track_id']
      endpoint = "tracks/#{track_id}/vote/#{channel_id}/#{direction}"
      api.post endpoint
    end

    def member
      api.session['member']
    end

    def favorites
      member['network_favorite_channels']
    end

  private

    def channels!
      response = cache.get "#{network}/channels" do
        api.get 'channels'
      end

      result = {}
      response.each do |channel|
        result[channel['key']] = channel
      end

      result
    end

    def channel_key_to_id(channel_key)
      return channel_key if channel_key.to_s =~ /^\d+$/
      channel = channels[channel_key]
      raise ArgumentError, "Invalid channel '#{channel_key}" unless channel
      channel['id']
    end

    def api
      @api ||= API.new network, user: user, password: password
    end

  end
end
