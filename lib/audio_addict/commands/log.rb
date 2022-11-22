module AudioAddict
  module Commands
    class LogCmd < Base
      summary 'Manage local like-log'

      help 'This command provides access and utilities for the local log of liked tracks. Before you can use this command, make sure you have configured the path to your log.'

      usage 'radio log show [SEARCH]'
      usage 'radio log tail [--lines N]'
      usage 'radio log sort'
      usage 'radio log browse'
      usage 'radio log tree [--save FILE]'
      usage 'radio log --help'

      option '-l --lines N', 'Number of lines to show [default: 5]'
      option '-s --save FILE', 'Save the tree output to a YAML file'

      param 'SEARCH', 'Show only log lines matching this string'

      command 'show', 'Show the entire like log'
      command 'tail', 'Show the last few rows of the like log'
      command 'sort', 'Sort the log alphabetically and save it'
      command 'browse', 'Browse the log file interactively'
      command 'tree', 'Show or save the log as YAML'

      example 'radio log show'
      example 'radio log show paramore'
      example 'radio log tail'
      example 'radio log tail --lines 10'
      example 'radio log sort'
      example 'radio log tree --save out.yml'

      def show_command
        needs :like_log
        query = args['SEARCH']
        puts query ? log.search(query) : log.data
      end

      def tail_command
        needs :like_log
        lines = args['--lines'].to_i
        puts log.data[-lines..]
      end

      def sort_command
        needs :like_log
        log.sort
        say '!txtgrn!Sorted'
      end

      def browse_command
        tree = log.tree

        say ''
        network = prompt.select 'Network:', tree.keys, symbols: { marker: '>' }, filter: true, per_page: 10
        channel = prompt.select 'Channel:', tree[network].keys, symbols: { marker: '>' }, filter: true,
          per_page: page_size
        artist = prompt.select 'Artist:', tree[network][channel].keys, symbols: { marker: '>' }, filter: true,
          per_page: page_size

        say 'Songs:'
        tree[network][channel][artist].each { |song| say "- !txtgrn!#{song}" }
        say ''

        browse_command if prompt.yes?('Again?')
      end

      def tree_command
        yaml = log.tree.to_yaml
        filename = args['--save']

        if filename
          File.write filename, yaml
          say "!txtgrn!Saved #{filename}"
        else
          puts yaml
        end
      end

    private

      def log
        @log ||= Log.new
      end

      def page_size
        @page_size ||= detect_terminal_size[1] - 4
      end
    end
  end
end
