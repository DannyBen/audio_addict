require 'spec_helper'

describe Log do
  subject { described_class.new }

  describe '#data' do
    context "when the log file does not exist" do
      it "returns an empty array" do
        FileUtils.rm subject.path if File.exist? subject.path
        expect(subject.data).to eq []
      end
    end
  end
end
