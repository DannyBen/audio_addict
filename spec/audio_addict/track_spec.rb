require 'spec_helper'

describe Track do
  subject { described_class.new nil, properties }

  let(:properties) { { 'title' => 'Track Title', 'track_id' => 23, 'artist' => 'Artist Name' } }

  describe '#inspect' do
    it 'returns a reasonable string' do
      expect(subject.inspect).to eq '#<AudioAddict::Track @title="Track Title", @artist="Artist Name", @id="23">'
    end
  end
end
