require 'spec_helper'

describe Commands::PlaylistCmd do
  subject { CLI.router }

  before do 
    reset_tmp_dir
  end

  describe "init" do
    it "generates the YAML and PLS files properly" do
      Dir.chdir 'spec/tmp' do
        FileUtils.rm 'mylist.yml' if File.exist? 'mylist.yml'
        FileUtils.rm 'mylist.pls' if File.exist? 'mylist.pls'

        interactive "y", "y" do
          subject.run %w[playlist init mylist]
        end

        expect(File.read 'mylist.yml').to match_fixture 'playlist/mylist.yml'
        expect(File.read 'mylist.pls').to match_fixture 'playlist/mylist.pls'
      end
    end
  end
end
