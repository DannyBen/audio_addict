module AudioAddict
  class Youtube
    include Inspectable

    attr_reader :query

    def initialize(query)
      @query = query
    end

    def inspectable
      [:query]
    end

    def get(count = 1)
      raise DependencyError, "This command requires youtube-dl" unless command_exist? 'youtube-dl'
      system command count: count, query: query
    end

    def command(args)
      command_template % args
    end

  private

    def command_template
      @command_template ||= %Q[youtube-dl --extract-audio --audio-format mp3 ytsearch%{count}:"%{query}"]
    end
  end
end
