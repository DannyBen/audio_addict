module AudioAddict
  module Commands
    class PlaylistCmd < Base
      summary "Generate playlists" 

      help "This command lets you generate playlists for the active network. In order to allow configuration, the process is done in two stages: 'init' and 'generate'."

      usage "radio playlist init NAME"
      usage "radio playlist generate NAME"
      usage "radio playlist --help"

      command "init", "Create a playlist configuration file. This step is required prior to using the generate command. After you generate this file, feel free to edit it to your preferences (sort order, remove channels etc)."
      command "generate", "Generate a playlist file based on the configuration file."

      param "NAME", "The name of the playlist without any extension"

      example "radio playlist init MyRockMusic"
      example "radio playlist generate MyRockMusic"

      def init_command
        needs :network, :channel, :listen_key

        require_premium_account

        name = args['NAME']
        outfile = "#{name}.yml"

        say "!txtred!Warning!txtrst!: !txtgrn!#{outfile}!txtrst! already exists!" if File.exist? outfile
        proceed = prompt.yes? "Create #{outfile}?"
        if proceed
          generate_config outfile
          say ""
          generate_command name
        end
      end

      def generate_command(name=nil)
        needs :network, :channel, :listen_key

        require_premium_account

        name ||= args['NAME']

        infile = "#{name}.yml"
        outfile = "#{name}.pls"

        if !File.exist? infile
          say "!txtred!Cannot find #{infile}"
        else
          say "!txtred!Warning!txtrst!: !txtgrn!#{outfile}!txtrst! already exists!" if File.exist? outfile
          proceed = prompt.yes? "Create #{outfile}?"
          generate_playlist infile, outfile if proceed
        end
      end

    private

      def generate_config(outfile)
        data = {
          template: "http://prem2.#{radio.domain}:80/%{channel_key}?%{listen_key}"
        }

        channels = {}
        
        radio.channels.each do |key, channel|
          key = fix_key key.to_sym
          channels[key] = channel.name
        end

        data[:channels] = channels

        File.write outfile, data.to_yaml
        say "Saved !txtgrn!#{outfile}"
      end

      def generate_playlist(infile, outfile)
        data = YAML.load_file infile
        template = data[:template]
        channels = data[:channels]

        output = []
        output << "[playlist]"
        output << "NumberOfEntries=#{channels.count}"

        index = 0

        channels.each do |key, name|
          index += 1
          output << "File#{index}=#{template}" % template_params(key)
          output << "Title#{index}=#{name}"
          output << "Length#{index}=0"
        end

        output = output.join("\n") + "\n"

        File.write outfile, output
        say "Saved !txtgrn!#{outfile}"
      end

      def template_params(channel_key)
        { listen_key: listen_key, channel_key: channel_key }
      end

      def listen_key
        Config.listen_key
      end

      # This is a patch to circumvent some anomalies in the AudioAddict API
      def fix_key(key)
        key = :electrohouse if current_network == 'di' and key == :electro
        key
      end

    end
  end
end