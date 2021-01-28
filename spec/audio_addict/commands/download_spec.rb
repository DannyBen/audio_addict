require 'spec_helper'

describe Commands::DownloadCmd do
  subject { CLI.router }

  describe "get" do
    before do
      expect_any_instance_of(Youtube).to receive(:command_exist?).with('youtube-dl').and_return true
    end

    context "when AUDIO_ADDICT_DOWNLOAD_DRY_RUN is unset" do
      before do
        ENV['AUDIO_ADDICT_DOWNLOAD_DRY_RUN'] = nil
      end

      after do
        ENV['AUDIO_ADDICT_DOWNLOAD_DRY_RUN'] = '1'
      end

      it "runs the system command" do
        expect_any_instance_of(Youtube).to receive(:system).and_return(true)
        expect { subject.run %w[download current] }.to output_approval('commands/download current (system call)')
      end
    end

    context "with AUDIO_ADDICT_DOWNLOAD_COUNT" do
      before { ENV['AUDIO_ADDICT_DOWNLOAD_COUNT'] = "2" }
      after { ENV['AUDIO_ADDICT_DOWNLOAD_COUNT'] = nil }

      it "uses the value for --count" do
        expect { subject.run %w[download current] }.to output_approval('commands/download current env (system call)')
      end
    end
  end
end
