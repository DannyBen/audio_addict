require 'spec_helper'

describe Commands::LogCmd do
  subject { CLI.router }

  before do 
    reset_tmp_dir
  end

  describe "tree --save FILE" do
    it "saves the YAML files properly" do
      Dir.chdir 'spec/tmp' do
        FileUtils.rm 'logtree.yml' if File.exist? 'logtree.yml'
        reset_like_log

        capture_output do
          subject.run %w[log tree --save logtree.yml]
        end

        expect(File.read 'logtree.yml').to match_approval 'log/logtree.yml'
      end
    end
  end

  describe 
end
