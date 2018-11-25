module AudioAddict
  class Channel
    include Cache
    include AutoProperties
    include Inspectable
    
    attr_reader :radio

    def initialize(radio, properties)
      @radio, @properties  = radio, properties
    end

    def inspectable
      [:key, :name, :id]
    end

    def track_history
      response = radio.api.get "track_history/channel/#{id}"
      response.map { |track| Track.new self, track }
    end

    def current_track
      track_history.first
    end

    def vote(direction = :up)
      track_id = current_track.id
      endpoint = "tracks/#{track_id}/vote/#{id}/#{direction}"
      radio.api.post endpoint
    end
  end
end
