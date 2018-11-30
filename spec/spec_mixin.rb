module SpecMixin
  def prepare_dummy_config
    Config.path = 'spec/fixtures/config.yml'
    Config.session_key = "dummy-session"
    Config.listen_key = "dummy-listen"
    Config.network = "di"
    Config.channel = "trance"
    Config.save
  end
end