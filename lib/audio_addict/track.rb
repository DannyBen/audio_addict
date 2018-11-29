module AudioAddict
  class Track
    include AutoProperties
    include Inspectable

    attr_reader :channel

    def initialize(channel, properties)
      @channel, @properties  = channel, properties
    end

    def inspectable
      [:title, :artist, :id]
    end

    def id
      properties['track_id']
    end

    # This is only here due to the global Runfile method with the same name
    def title
      properties['title']
    end
  end
end
