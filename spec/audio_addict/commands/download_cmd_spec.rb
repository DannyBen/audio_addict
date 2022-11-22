require 'spec_helper'

describe Commands::DownloadCmd do
  subject { described_class.new }

  let(:youtube_double) { instance_double Youtube, :get }

  describe 'get' do
    context 'when AUDIO_ADDICT_DOWNLOAD_DRY_RUN is unset' do
      before do
        ENV['AUDIO_ADDICT_DOWNLOAD_DRY_RUN'] = nil
      end

      after do
        ENV['AUDIO_ADDICT_DOWNLOAD_DRY_RUN'] = '1'
      end

      it 'delegates to Youtube#get' do
        allow(Youtube).to receive(:new).and_return youtube_double
        expect(youtube_double).to receive(:get)
        expect { subject.execute %w[download current] }.to output_approval('commands/download current (system call)')
      end
    end

    context 'with AUDIO_ADDICT_DOWNLOAD_COUNT' do
      before { ENV['AUDIO_ADDICT_DOWNLOAD_COUNT'] = '2' }
      after { ENV['AUDIO_ADDICT_DOWNLOAD_COUNT'] = nil }

      it 'uses the value for --count' do
        expect { subject.execute %w[download current] }
          .to output_approval('commands/download current env (system call)')
      end
    end
  end
end
