require 'spec_helper'

describe Channel do
  subject { described_class.new nil, properties }

  let(:properties) { { 'key' => 'heavymetal', 'id' => 23, 'name' => 'Heavy Metal' } }

  describe '#inspect' do
    it 'returns a reasonable string' do
      expect(subject.inspect).to eq '#<AudioAddict::Channel @key="heavymetal", @name="Heavy Metal", @id="23">'
    end
  end
end
