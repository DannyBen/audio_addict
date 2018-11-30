require 'spec_helper'

describe Track do
  let(:properties) { { 'title' => "Track Title", 'track_id' => 23, "artist" => "Artist Name" } }
  subject { described_class.new nil, properties }

  describe '#inspect' do
    it "works" do
      expect(subject.inspect).to eq "#<AudioAddict::Track @title=\"Track Title\", @artist=\"Artist Name\", @id=\"23\">"
    end
  end
end
