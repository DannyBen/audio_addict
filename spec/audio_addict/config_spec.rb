require 'spec_helper'

describe Config do
  subject { described_class }

  describe '#default_path' do
    it 'returns the correct path' do
      expect(subject.default_path).to include '.audio_addict/config'
    end
  end

  describe '#respond_to?' do
    it 'returns true always' do
      expect(subject.respond_to? :anything).to be true
    end
  end
end
