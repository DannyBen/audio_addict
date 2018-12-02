module AudioAddict
  module Commands
    class LogCmd < Base
      summary "Manage local like log"

      usage "radio log show"
      usage "radio log tail [--lines N]"
      # usage "radio log sort"
      usage "radio log --help"

      option "-l --lines N", "Number of lines to show [default: 5]"

      command "show", "Show the entire like log"
      command "tail", "Show the last few rows of the like log"
      # command "sort", "Sort the log alphabetically and save it"

      example "radio log show"
      example "radio log tail"
      example "radio log tail --lines 10"
      example "radio log sort"

      def show_command(args)
        setup
        puts File.read(Config.like_log)
      end

      def tail_command(args)
        setup
        lines = args['--lines'].to_i
        puts File.readlines(Config.like_log)[-lines..-1]
      end

    private

      def setup
        needs :like_log
        raise Error, "File not found: #{Config.like_log}" unless File.exist? Config.like_log
      end

    end
  end
end