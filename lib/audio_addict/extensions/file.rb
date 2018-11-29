require 'fileutils'

class File
  def self.contains?(file, content)
    foreach file do |line|
      return true if line.chomp == content
    end
    return false
  end

  def self.append(file, content)
    open(file, 'a') { |f| f.puts content }
  end

  def self.deep_write(file, content)
    dir = File.dirname file
    FileUtils.mkdir_p dir unless Dir.exist? dir
    File.write file, content
  end
end
