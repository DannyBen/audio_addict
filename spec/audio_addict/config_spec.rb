require 'spec_helper'

describe Config do
  subject { described_class }

  describe '#default_path' do
    it "works" do
      expect(subject.default_path).to include ".audio_addict/config"
    end
  end
end
