require 'spec_helper'

describe Youtube do
  subject { described_class.new query }

  let(:query) { 'Brimstone, Intake' }

  describe '#inspect' do
    it 'returns a reasonable string' do
      expect(subject.inspect).to eq %[#<AudioAddict::Youtube @query="#{query}">]
    end
  end

  describe '#command' do
    it 'returns the youtube-dl command' do
      expect(subject.command query: query, count: 3).to match_approval('youtube-dl/sample')
    end
  end

  describe '#get' do
    context 'when youtube-dl is available' do
      before do
        allow(subject).to receive(:command_exist?)
          .with('youtube-dl')
          .and_return true
      end

      it 'downloads the song from youtube' do
        expect { subject.get }.to output_approval('youtube-dl/get')
      end

      context 'when youtube-dl fails' do
        it 'raises an error' do
          allow(subject).to receive(:execute).and_return false
          expect { subject.get }.to raise_error(DependencyError, /exited with an error/)
        end
      end
    end

    context 'when youtube-dl is not available' do
      before do
        allow(subject).to receive(:command_exist?)
          .with('youtube-dl')
          .and_return false
      end

      it 'raises an error' do
        expect { subject.get }.to raise_error(DependencyError, /requires youtube-dl/)
      end
    end
  end
end
