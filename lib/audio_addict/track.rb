module AudioAddict
  class Track
    include AutoProperties
    include Inspectable

    attr_reader :channel

    def initialize(channel, properties)
      @channel, @properties = channel, properties
    end

    def inspectable
      [:title, :artist, :id]
    end

    def id
      properties["track_id"]
    end

    def title
      properties["title"].strip
    end

    def search_string
      "#{artist}, #{title}"
    end
  end
end
