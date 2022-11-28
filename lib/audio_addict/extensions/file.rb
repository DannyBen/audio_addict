require 'fileutils'

class File
  class << self
    def contains?(file, content)
      return false unless File.exist? file

      foreach file do |line|
        return true if line.chomp == content
      end

      false
    end

    def append(file, content)
      File.open(file, 'a') { |f| f << "#{content}\n" }
    end

    def deep_write(file, content)
      dir = File.dirname file
      FileUtils.mkdir_p dir unless Dir.exist? dir
      File.write file, content
    end
  end
end
