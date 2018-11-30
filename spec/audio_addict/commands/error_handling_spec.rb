require 'spec_helper'

describe 'commands (error handling)' do
  require_mock_server!

  subject { AudioAddict::CLI.router }

  before do 
    AudioAddict::API.base_uri "http://localhost:3000"
    reset_config
    reset_tmp_dir
  end

  describe "missing needed config values" do
    before { Config.delete :network }

    it "raises an error" do
      expect{ subject.run ["channels"] }.to raise_error(ConfigError)
      expect{ subject.run ["now"] }.to raise_error(ConfigError)
      expect{ subject.run ["playlist", "init", "hello"] }.to raise_error(ConfigError)
      expect{ subject.run ["vote"] }.to raise_error(ConfigError)
    end
  end
end
