require 'lightly'

module AudioAddict
  module Cache

    def cache
      @cache ||= Lightly.new life: '6h', dir: cache_dir
    end

  private

    def cache_dir
      @cache_dir ||= cache_dir!
    end

    def cache_dir!
      ENV['AUDIO_ADDICT_CACHE_DIR'] || "#{Dir.home}/.audio_addict/cache"
    end

  end
end
