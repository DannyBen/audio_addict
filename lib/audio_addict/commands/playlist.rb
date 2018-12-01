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

      def init_command(args)
        needs :network, :channel, :listen_key

        name = args['NAME']
        outfile = "#{name}.yml"

        say "!txtred!Warning!txtrst!: !txtgrn!#{outfile}!txtrst! already exists!" if File.exist? outfile
        proceed = prompt.yes? "Create #{outfile}?"
        if proceed
          generate_config outfile
          say ""
          generate_command({ 'NAME' => name }) # we also generate the playlist
        end
      end

      def generate_command(args)
        needs :network, :channel, :listen_key

        name = args['NAME']

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

        channels = []
        
        radio.channels.each do |key, channel|
          channel_data = { name: channel.name, key: key, active: true }
          channels << channel_data
        end

        data[:channels] = channels

        File.write outfile, data.to_yaml
        say "Saved !txtgrn!#{outfile}"
      end

      def generate_playlist(infile, outfile)
        data = YAML.load_file infile
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

        File.write outfile, output
        say "Saved !txtgrn!#{outfile}"
      end

      def template_params(channel_key)
        { listen_key: listen_key, channel_key: channel_key }
      end

      def listen_key
        Config.listen_key
      end

    end
  end
end