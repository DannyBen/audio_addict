require 'spec_helper'

describe Commands::ConfigCmd do
  subject { described_class.new }

  describe 'edit' do
    before { Config.save }

    it 'opens the system editor' do
      ENV['EDITOR'] = 'edit'
      expect(subject).to receive(:system).with("edit #{Config.path}")
      subject.execute %w[config edit]
    end
  end
end
