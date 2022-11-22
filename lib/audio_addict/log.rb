module AudioAddict
  class Log
    def path
      @path ||= Config.like_log
    end

    def data
      @data ||= data!
    end

    def data!
      if File.exist? path
        File.readlines(path).map(&:strip)
      else
        []
      end
    end

    def search(query)
      data.select { |l| l.downcase.include? query.downcase }
    end

    def sort
      output = "#{data.sort.join("\n")}\n"
      File.write path, output
    end

    def tree
      @tree ||= tree!
    end

    def tree!
      result = {}

      data.each do |line|
        network, channel, artist, song = line.split(' :: ')
        result[network] ||= {}
        result[network][channel] ||= {}
        result[network][channel][artist] ||= []
        result[network][channel][artist] << song
      end

      result
    end
  end
end
