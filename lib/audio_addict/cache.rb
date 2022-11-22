require 'lightly'

module AudioAddict
  module Cache
    def cache
      @cache ||= Lightly.new life: cache_life, dir: cache_dir
    end

    def cache_life
      @cache_life ||= cache_life!
    end

    def cache_life!
      Config.cache_life || '6h'
    end

    def cache_dir
      @cache_dir ||= cache_dir!
    end

    def cache_dir!
      Config.cache_dir || "#{Dir.home}/.audio_addict/cache"
    end
  end
end
