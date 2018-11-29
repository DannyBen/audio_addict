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

    def active?
      # Seems like each network has a different way of marking inactive channels.
      # This is where we normalize it
      return false if !properties['asset_id']
      return false if name[0] == 'X' and key[0] != 'x'
      return true
    end

    def track_history
      @track_history ||= track_history!
    end

    def track_history!
      response = radio.api.get "track_history/channel/#{id}"
      response.map { |track| Track.new self, track }
    end

    def current_track
      track_history.first
    end

    def vote(direction = :up)
      track_id = current_track.id
      endpoint = "tracks/#{track_id}/vote/#{id}"

      if direction == :delete
        radio.api.delete endpoint
      else
        radio.api.post "#{endpoint}/#{direction}"
      end

      log_like if direction == :up and Config.like_log
    end

  private

    def log_like
      message = "#{radio.name} :: #{name} :: #{current_track.artist} :: #{current_track.title}"
      file = Config.like_log
      File.append file, message unless File.contains? file, message
    end
    
  end
end
