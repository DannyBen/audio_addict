module AudioAddict
  module Commands
    class StatusCmd < Base
      summary "Show configuration status"

      usage "radio status [--unsafe]"
      usage "radio status --help"

      option "-u --unsafe", "Show the full session and listen keys"

      def keys
        {
          path: { 
            name: "Config Path", value: Config.path },

          email: { 
            name: "Email", command: 'login' },

          session_key: { 
            name: "Session Key", command: 'login', secret: true },

          listen_key: { 
            name: "Listen Key", command: 'login', secret: true },

          network: { 
            name: "Network", command: 'set' },

          channel: { 
            name: "Channel", command: 'set' },

          like_log: { 
            name: "Like Log", command: 'config like_log PATH' },
        }
      end

      def run(args)
        keys.each do |key, info|
          value = info[:value] || Config.properties[key]

          if value and !args['--unsafe'] and info[:secret]
            value = "***#{value[-4, 4]}" 
          end
          
          if value
            display_value = "!txtgrn!#{value}!txtrst!"
          else
            display_value = "!txtred!<Unset>!txtrst!"
            if info[:command]
              display_value = "#{display_value} - set with !txtpur!radio #{info[:command]}"
            end
          end

          say "!txtblu!#{info[:name].rjust 14}!txtrst! : #{display_value}"
        end

      end
    end
  end
end