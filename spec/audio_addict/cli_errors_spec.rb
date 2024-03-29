require 'spec_helper'

describe CLI do
  subject { described_class.router }

  before do
    reset_config
  end

  describe 'missing config values' do
    before { Config.delete :network }

    it 'raises errors' do
      expect { subject.run ['channels'] }.to raise_error(ConfigError)
      expect { subject.run ['now'] }.to raise_error(ConfigError)
      expect { subject.run %w[playlist init hello] }.to raise_error(ConfigError)
      expect { subject.run ['vote'] }.to raise_error(ConfigError)
    end
  end

  describe 'playlist for non premium users' do
    before { Config.premium = false }

    it 'raises error' do
      expect { subject.run %w[playlist init hello] }.to raise_error(PremiumAccount)
    end
  end
end
