require 'yaml'

module AudioAddict
  class Config
    class << self
      attr_writer :path

      def method_missing(name, *args, &)
        if name.to_s.end_with? '='
          name = name[0..-2].to_sym
          properties[name] = args.first
        else
          properties[name]
        end
      end

      def respond_to_missing?(*_args)
        true
      end

      def delete(*keys)
        keys.each { |key| properties.delete key.to_sym }
      end

      def save
        File.deep_write path, sorted_properties.to_yaml
      end

      def has_key?(key)
        properties.has_key? key.to_sym
      end

      def properties
        @properties ||= properties!
      end

      def properties!
        File.exist?(path) ? YAML.load_file(path) : {}
      end

      def sorted_properties
        properties.sort.to_h
      end

      def path
        @path ||= ENV.fetch('AUDIO_ADDICT_CONFIG_PATH', default_path)
      end

      def default_path
        "#{Dir.home}/.audio_addict/config"
      end
    end
  end
end
