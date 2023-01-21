module AudioAddict
  module Commands
    class ConfigCmd < Base
      summary 'Manage local configuration'

      help 'This command provides low level access to your local configuration file.'

      usage 'radio config set KEY VALUE'
      usage 'radio config get KEY'
      usage 'radio config del KEY'
      usage 'radio config show'
      usage 'radio config edit'
      usage 'radio config check'
      usage 'radio config guide'
      usage 'radio config --help'

      param 'KEY', 'Config key'
      param 'VALUE', 'Config value'

      option '-s --show', 'Show the contents of the config file'
      option '-e --edit', 'Open the config file for editing'

      command 'get', 'Show the value of this config key'
      command 'set', 'Set the value of this config key'
      command 'del', 'Delete the value of this config key'
      command 'show', 'Show the entire config file contents'
      command 'edit', 'Open the config file for editing'
      command 'guide', 'Show a list of supported config keys and their purpose'
      command 'check', 'Verify and report problems with the config file'

      example 'radio config edit'
      example 'radio config set like_log ~/like.log'
      example 'radio config del session_key'
      example 'radio config get listen_key'

      def get_command
        key = args['KEY'].to_sym
        value = Config.properties[key]
        say value ? "g`#{value}`" : 'r`<Unset>`'
      end

      def set_command
        key = args['KEY'].to_sym
        value = args['VALUE']
        Config.properties[key] = value
        Config.save
        say "g`#{key}=#{value}`"
      end

      def del_command
        key = args['KEY'].to_sym
        Config.delete key
        Config.save
        say 'g`Deleted`'
      end

      def show_command
        say "mu`# #{Config.path}`"
        if File.exist? Config.path
          puts File.read Config.path
        else
          say 'r`File Not Found`'
        end
      end

      def edit_command
        editor = ENV['EDITOR'] || 'vi'
        system "#{editor} #{Config.path}"
      end

      def guide_command
        key_guide.each do |key, value|
          say "g`#{key}`"
          say word_wrap "  #{value}"
          say ''
        end
      end

      def check_command
        errors = verify_and_show_keys required_keys, critical: true
        warnings = verify_and_show_keys optional_keys

        say "Done. #{errors} errors, #{warnings} warnings."
        errors.positive? ? 1 : 0
      end

    private

      def verify_and_show_keys(keys, critical: false)
        problems = 0
        prefix = critical ? '!txtred!Error  !txtrst!' : '!txtylw!Warning!txtrst!'

        keys.each do |key, command|
          unless Config.has_key? key
            problems += 1
            say "#{prefix} : Key g`#{key}` is not set. Fix with m`radio #{command}`."
          end
        end

        problems
      end

      def key_guide
        {
          email:       "Last email used for logging in.\nUsually set with !txtpur!radio login!txtrst!.",
          session_key: "Used for authentication.\nUsually set with !txtpur!radio login!txtrst!.",
          listen_key:  "Used for generating playlists.\nUsually set with !txtpur!radio login!txtrst!.",
          network:     "Specify the AudioAddict network you are currently listening to.\nUsually set with !txtpur!radio set!txtrst!.",
          channel:     "Specify the AudioAddict channel you are currently listening to.\nUsually set with !txtpur!radio set!txtrst!.",
          like_log:    "Specify the path to store all your positive votes.\nIf this is not set, votes will only be sent to AudioAddict and not logged locally.",
          cache_dir:   "Specify the path to store API response cache.\nDefault: ~/.audio_addict/cache",
          cache_life:  "Specify the cache life period.\nDefault: 6h.",
        }
      end

      def required_keys
        {
          email:       'login',
          session_key: 'login',
          listen_key:  'login',
          network:     'set',
          channel:     'set',
        }
      end

      def optional_keys
        {
          like_log: 'config set like_log PATH',
        }
      end
    end
  end
end
