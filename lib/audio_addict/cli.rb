require 'super_docopt'
require 'colsole'
require 'tty/prompt'

module AudioAddict
  class CLI < SuperDocopt::Base
    include Colsole

    version VERSION
    docopt File.expand_path 'docopt.txt', __dir__
    subcommands ['set', 'channels', 'current', 'vote']

    def set
      network = args['NETWORK']
      channel = args['CHANNEL']

      if network
        if !Radio.valid_network? network
          say "Invalid network !txtred!#{network}"
          say "Valid options are: #{Radio::NETWORKS.join ', '}"
          exit 1
        end

        Config.network = network
      end

      Config.channel = channel
      Config.save
      say "Saved to !txtpur!#{Config.path}"
    end

    def channels
      search = args['SEARCH']
      channels = radio.channels.values

      if search
        channels.select! { |c| "#{c.key} #{c.name.downcase}".include? search.downcase } 
      end
      
      channels.each do |channel|
        say "!txtgrn!#{channel.key.rjust 25} !txtblu!#{channel.name.strip}"
      end
    end

    def current
      say "!txtgrn!Network: !txtblu!#{Config.network}"
      say "!txtgrn!Channel: !txtblu!#{current_channel.name}!txtrst! (#{current_channel.key})"

      track = current_channel.current_track
      say "!txtgrn!  Track: !txtblu!#{track.title.strip}"
      say "!txtgrn!     By: !txtblu!#{track.artist.strip}"
    end

    def vote
      current
      puts "------------------------------------------------------------\n"
      answer = get_user_vote
      exit if answer == :abort

      current_channel.vote answer
    end

  private

    def radio
      @radio ||= Radio.new Config.network
    end

    def current_channel
      radio[Config.channel]
    end

    def prompt
      @prompt ||= TTY::Prompt.new
    end

    def get_user_vote
      options = { "Like" => :up, "Dislike" => :down, "Unvote" => :delete, "Abort" => :abort }
      prompt.select "Vote", options, marker: '>'
    end

  end
end

