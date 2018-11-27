module AudioAddict
  module Commands
    class ChannelCmd < Base
      summary "Set the radio channel"

      help "Save the channel to the config file for future use"

      usage "radio channel [CHANNEL]"
      usage "radio channel --help"

      param "CHANNEL", "AudioAddict channel key or a partial search string.\nLeave empty for an interactive prompt."

      example "radio channel"
      example "radio channel modern"
      example "radio channel modernrock"

      def run(args)
        channel = args['CHANNEL']

        if !channel
          interactive_menu

        elsif radio.valid_channel? channel
          save channel
        
        elsif radio.search(channel).any?
          interactive_menu channel

        else
          say "!txtred!Invalid channel: #{radio.name} > #{channel}"
          say "Run without a channel name for an interactive list"

        end
      end

    private

      def save(channel)
        Config.channel = channel
        Config.save
        say "Saved !txtgrn!#{radio.name} > #{current_channel.name}!txtrst! # #{channel}"
      end

      def interactive_menu(channel = nil)
        list = channel ? radio.search(channel).values : radio.channels.values

        answer = get_user_input list
        abort if answer == :abort
        save answer
      end

      def get_user_input(channels)
        options = channels.map { |channel| ["#{channel.name.ljust 20} # #{channel.key}", channel.key] }.to_h
        options = { "Abort" => :abort }.merge options
        prompt.select "Choose a Channel :", options, marker: '>'
      end

    end
  end
end