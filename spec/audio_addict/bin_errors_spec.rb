require 'spec_helper'

describe 'bin/radio error handling' do
  before do
    ENV['AUDIO_ADDICT_CONFIG_PATH']='tmp/config.yml'
    Config.premium = false
    Config.save
  end

  it "errors gracefully" do
    expect(`bin/radio playlist init hello`).to match_fixture('bin/premium_error')
  end
end
