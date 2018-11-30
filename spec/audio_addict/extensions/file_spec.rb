require 'spec_helper'

describe File do
  describe '#contains?' do
    subject { 'spec/tmp/filetest' }

    context "when the file does not exist" do
      before { File.delete subject if File.exist? subject }

      it "returns false" do
        expect(File.contains? subject, "some string").to be false
      end
    end
    
    context "when the file exists" do
      before { File.write subject, "some string" }

      context "and contains the string" do
        it "returns true" do
          expect(File.contains? subject, "some string").to be true
        end
      end

      context "and does not contain the string" do
        it "returns false" do
          expect(File.contains? subject, "some other string").to be false
        end
      end
    end
  end
end
