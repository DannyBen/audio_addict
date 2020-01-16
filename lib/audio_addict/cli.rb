module AudioAddict
  class CLI
    def self.router
      router = MisterBin::Runner.new version: VERSION,
                                     header: "AudioAddict Radio Utilities"

      router.route "login", to: Commands::LoginCmd
      router.route "set", to: Commands::SetCmd
      router.route "channels", to: Commands::ChannelsCmd
      router.route "now", to: Commands::NowCmd
      router.route "history", to: Commands::HistoryCmd
      router.route "vote", to: Commands::VoteCmd
      router.route "playlist", to: Commands::PlaylistCmd
      router.route "config", to: Commands::ConfigCmd
      router.route "log", to: Commands::LogCmd
      router.route "api", to: Commands::APICmd

      router
    end
  end
end
