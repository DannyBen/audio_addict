module AudioAddict
  class CLI
    def self.runner
      runner = MisterBin::Runner.new version: VERSION,
        header: "AudioAddict Radio Utilities"

      runner.route 'set',      to: Commands::SetCmd
      runner.route 'channels', to: Commands::ChannelsCmd
      runner.route 'current',  to: Commands::CurrentCmd
      runner.route 'vote',     to: Commands::VoteCmd

      runner
    end
  end

end
