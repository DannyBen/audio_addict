require 'spec_helper'

# This is a spec generator.
# It will generate several "it" statements, based on the commands.yml file.
# This particular test is responsible for the majority of the code coverage.
describe 'commands (generated specs)' do
  require_mock_server!

  subject { AudioAddict::CLI.router }

  commands = YAML.load_file 'spec/audio_addict/commands/commands.yml'
  commands = commands[:commands]

  before do 
    reset_config
    reset_tmp_dir
  end

  commands.each do |spec|
    it "works" do
      command = spec[:cmd]
      keyboard = spec[:kbd]
      tag = spec[:tag]&.to_sym

      test_name = "#{command}"
      test_name = "#{test_name} (#{keyboard.join ' '})" if keyboard
      test_name = "#{test_name} ##{tag}" if tag
      test_name = "#no-arguments" if test_name.empty?

      say "$ !txtpur!#{test_name}"

      fixture = test_name.gsub(/[^#\w\- \(\)\{\}\[\]]/, '')
      argv = command.split ' '
      
      Dir.chdir 'spec/tmp' do
        send tag if tag and respond_to? tag
        output = interactive(*keyboard) do
          subject.run argv
        end
        expect(output).to match_fixture "commands/#{fixture}"
      end

    end
  end

  def missing_config
    Config.delete :session_key, :listen_key, :network, :channel, :like_log
  end

  def create_config
    Config.save
  end
end
