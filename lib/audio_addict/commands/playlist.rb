module AudioAddict
  module Commands
    class PlaylistCmd < Base
      summary "Generate playlists" 

      usage "radio playlist init NAME"
      usage "radio playlist generate NAME"
      usage "radio playlist --help"

      command "init", "Create a playlist configuration file. This step is required prior to using the generate command."
      command "generate", "Generate a playlist file based on the configuration file."

      param "NAME", "The name of the playlist without any extension"

      example "radio playlist init MyRockMusic"
      example "radio playlist generate MyRockMusic"

      def run(args)
        needs :network, :channel, :listen_key

        @args = args
        @filename = "#{@args['NAME']}"

        init_command if args['init']
        generate_command if args['generate']
      end

    private

      def init_command
        @outfile = "#{@filename}.yml"

        say "This will generate the !txtgrn!#{@outfile}!txtrst! configuration file."
        say "!txtred!Warning: File already exists!" if File.exist? @outfile
        proceed = prompt.yes? "Proceed?"
        generate_config if proceed
      end

      def generate_command
        @infile = "#{@filename}.yml"
        @outfile = "#{@filename}.pls"

        if !File.exist? @infile
          say "!txtred!Cannot find #{@infile}"
        else
          say "This will generate the !txtgrn!#{@outfile}!txtrst! playlist."
          say "!txtred!Warning: File already exists!" if File.exist? @outfile
          proceed = prompt.yes? "Proceed?"
          generate_playlist if proceed
        end
      end

      def generate_playlist
        data = YAML.load_file @infile
        template = data[:template]
        channels = data[:channels].select { |c| c[:active] }

        output = []
        output << "[playlist]"
        output << "NumberOfEntries=#{channels.count}"

        index = 0

        channels.each do |channel|
          index += 1
          output << "File#{index}=#{template}" % template_params(channel[:key])
          output << "Title#{index}=#{channel[:name]}"
          output << "Length#{index}=0"
        end

        output = output.join("\n") + "\n"

        File.write @outfile, output
        say "Saved !txtgrn!#{@outfile}"
      end

      def template_params(channel_key)
        { listen_key: listen_key, channel_key: channel_key }
      end

      def generate_config
        data = {
          template: "http://prem2.#{current_network}.com:80/%{channel_key}?%{listen_key}"
        }

        channels = []
        
        radio.channels.each do |key, channel|
          channel_data = { name: channel.name, key: key, active: true }
          channels << channel_data
        end

        data[:channels] = channels

        File.write @outfile, data.to_yaml
        say "Saved !txtgrn!#{@outfile}"

        proceed = prompt.yes? "Generate playlist as well?"
        generate_command if proceed

      end

      def listen_key
        Config.listen_key
      end

    end
  end
end