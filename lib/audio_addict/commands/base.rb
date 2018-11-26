require 'mister_bin'
require 'colsole'
require 'tty/prompt'

module AudioAddict
  module Commands
    class Base < MisterBin::Command

      def radio
        @radio ||= Radio.new Config.network
      end

      def current_channel
        radio[Config.channel]
      end

      def prompt
        @prompt ||= TTY::Prompt.new
      end

    end
  end
end