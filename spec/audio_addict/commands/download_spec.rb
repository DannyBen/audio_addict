require 'spec_helper'

describe Commands::DownloadCmd do
  subject { CLI.router }

  describe "get" do
    before do
      ENV['YOUTUBE_DL_DRY_RUN'] = nil
      expect_any_instance_of(Youtube).to receive(:command_exist?).with('youtube-dl').and_return true
    end

    after do
      ENV['YOUTUBE_DL_DRY_RUN'] = '1'
    end

    it "runs the system command" do
      expect_any_instance_of(Youtube).to receive(:system).and_return(true)
      expect { subject.run %w[download current] }.to output_approval('commands/download current (system call)')
    end
  end
end
