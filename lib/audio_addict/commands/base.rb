require 'mister_bin'
require 'colsole'
require 'tty/prompt'

module AudioAddict
  module Commands
    class Base < MisterBin::Command

      def needs(*config_keys)
        missing = []
        config_keys.each do |key|
          missing.push key unless Config.has_key? key
        end

        raise ConfigError, missing if missing.any?
      end

      def require_premium_account
        raise PremiumAccount unless Config.premium
      end

      def radio
        @radio ||= Radio.new current_network
      end

      def current_network
        Config.network
      end

      def current_channel
        @current_channel ||= radio[Config.channel]
      end

      def prompt
        @prompt ||= TTY::Prompt.new
      end

    end
  end
end