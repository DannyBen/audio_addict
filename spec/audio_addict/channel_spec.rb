require 'spec_helper'

describe Channel do
  let(:properties) { { 'key' => "heavymetal", 'id' => 23, "name" => "Heavy Metal" } }
  subject { described_class.new nil, properties }

  describe '#inspect' do
    it "works" do
      expect(subject.inspect).to eq "#<AudioAddict::Channel @key=\"heavymetal\", @name=\"Heavy Metal\", @id=\"23\">"
    end
  end
end
