require 'yaml'

module AudioAddict
  class Config
    class << self
      def network=(value)
        properties[:network] = value
      end

      def network
        properties[:network]
      end

      def channel=(value)
        properties[:channel] = value
      end

      def channel
        properties[:channel]
      end

      def save
        File.deep_write path, properties.to_yaml
      end

      def properties
        @properties ||= properties!
      end

      def properties!
        File.exist?(path) ? YAML.load_file(path) : {}
      end

      def path
        "#{Dir.home}/.audio_addict/config"
      end
    end
  end
end
