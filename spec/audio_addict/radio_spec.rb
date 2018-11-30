require 'spec_helper'

describe Radio do
  subject { described_class.new 'di' }

  describe '#inspect' do
    it "works" do
      expect(subject.inspect).to eq "#<AudioAddict::Radio @network=\"di\">"
    end
  end
end
