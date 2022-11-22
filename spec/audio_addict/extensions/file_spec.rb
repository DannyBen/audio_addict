require 'spec_helper'

describe File do
  describe '#contains?' do
    subject { 'spec/tmp/filetest' }

    context 'when the file does not exist' do
      before { described_class.delete subject if described_class.exist? subject }

      it 'returns false' do
        expect(described_class.contains? subject, 'some string').to be false
      end
    end

    context 'when the file exists' do
      before { described_class.write subject, 'some string' }

      context 'when it contains the string' do
        it 'returns true' do
          expect(described_class.contains? subject, 'some string').to be true
        end
      end

      context 'when it does not contain the string' do
        it 'returns false' do
          expect(described_class.contains? subject, 'some other string').to be false
        end
      end
    end
  end
end
