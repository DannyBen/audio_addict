require 'spec_helper'

describe File do
  subject { described_class }

  let(:tempfile) { 'spec/tmp/filetest' }

  describe '#append' do
    before { subject.write tempfile, "one\ntwo\n" }

    it 'adds new content to the bottom of the file with a trailing newline' do
      subject.append tempfile, 'three'
      expect(subject.read tempfile).to eq "one\ntwo\nthree\n"
    end
  end

  describe '#contains?' do
    context 'when the file does not exist' do
      before { subject.delete tempfile if subject.exist? tempfile }

      it 'returns false' do
        expect(subject.contains? tempfile, 'some string').to be false
      end
    end

    context 'when the file exists' do
      before { subject.write tempfile, 'some string' }

      context 'when it contains the string' do
        it 'returns true' do
          expect(subject.contains? tempfile, 'some string').to be true
        end
      end

      context 'when it does not contain the string' do
        it 'returns false' do
          expect(subject.contains? tempfile, 'some other string').to be false
        end
      end
    end
  end

  describe '#deep_write' do
    before { FileUtils.rm_rf 'spec/tmp/subdir' }

    let(:dir) { 'spec/tmp/subdir' }
    let(:tempfile) { "#{dir}/file.txt" }

    it 'writes to a file, creating all parent directories' do
      expect(Dir).not_to exist(dir)
      subject.deep_write tempfile, 'works'
      expect(subject.read tempfile).to eq 'works'
    end
  end
end
