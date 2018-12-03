module AudioAddict
  module Commands
    class LogCmd < Base
      summary "Manage local like log"

      usage "radio log show [SEARCH]"
      usage "radio log tail [--lines N]"
      usage "radio log sort"
      usage "radio log --help"

      option "-l --lines N", "Number of lines to show [default: 5]"

      param "SEARCH", "Show only log lines matching this string"

      command "show", "Show the entire like log"
      command "tail", "Show the last few rows of the like log"
      command "sort", "Sort the log alphabetically and save it"

      example "radio log show"
      example "radio log show paramore"
      example "radio log tail"
      example "radio log tail --lines 10"
      example "radio log sort"

      def show_command(args)
        setup
        search = args['SEARCH']
        if search
          puts File.readlines(logfile).select { |l| l.downcase.include? search.downcase }
        else
          puts File.read(logfile)
        end
      end

      def tail_command(args)
        setup
        lines = args['--lines'].to_i
        puts File.readlines(logfile)[-lines..-1]
      end

      def sort_command(args)
        setup
        lines = File.readlines logfile
        File.write logfile, lines.sort.join
        say "!txtgrn!Sorted"
      end

    private

      def setup
        needs :like_log
        raise Error, "File not found: #{logfile}" unless File.exist? logfile
      end

      def logfile
        @logfile ||= Config.like_log
      end

    end
  end
end