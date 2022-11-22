module AudioAddict
  class Youtube
    include Inspectable
    include Colsole

    attr_reader :query

    def initialize(query)
      @query = query
    end

    def inspectable
      [:query]
    end

    def get(count = nil)
      count ||= 1
      raise DependencyError, 'This command requires youtube-dl' unless command_exist? 'youtube-dl'

      success = execute command(count: count, query: query)
      raise DependencyError, 'youtube-dl exited with an error' unless success
    end

    def command(args)
      command_template % args
    end

  private

    def execute(command)
      if ENV['AUDIO_ADDICT_DOWNLOAD_DRY_RUN']
        puts "DRY RUN: #{command}"
        true
      else
        system command
      end
    end

    def command_template
      @command_template ||= %[youtube-dl --extract-audio --audio-format mp3 ytsearch%{count}:"%{query}"]
    end
  end
end
