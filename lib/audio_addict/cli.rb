require 'super_docopt'
require 'colsole'

module AudioAddict
  class CLI < SuperDocopt::Base
    include Colsole

    version VERSION
    docopt File.expand_path 'docopt.txt', __dir__
    subcommands ['set', 'listen', 'channels', 'current']

    def set
      Config.network = args['NETWORK']
      Config.save
    end

    def listen
      Config.channel = args['CHANNEL']
      Config.save
    end

    def channels
      radio = Radio.new Config.network
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
      radio = Radio.new Config.network
      channel = radio[Config.channel]

      say "!txtgrn!Network: !txtblu!#{Config.network}"
      say "!txtgrn!Channel: !txtblu!#{channel.name}!txtrst! (#{channel.key})"

      track = channel.current_track
      say "!txtgrn!  Track: !txtblu!#{track.title}"
      say "!txtgrn!     By: !txtblu!#{track.artist}"

    end
  end
end

