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
    AudioAddict::API.base_uri "http://localhost:3000"
    reset_config
    reset_tmp_dir
  end

  commands.each do |spec|
    command = spec[:cmd]
    keyboard = spec[:kbd]
    live = spec[:live]
    config = spec[:cfg]
    tag = spec[:tag]

    test_name = "#{command}"
    test_name = "#{test_name} (#{keyboard.join ' '})" if keyboard
    test_name = "#{test_name} ##{tag}" if tag
    test_name = "#no-arguments" if test_name.empty?

    it "works: #{test_name}" do
      fixture = test_name.gsub(/[^#\w\- \(\)\{\}\[\]]/, '')
      config.each { |key| Config.delete key } if config
      argv = command.split ' '
      
      Dir.chdir 'spec/tmp' do
        output = interactive *keyboard do
          subject.run argv
        end
        expect(output).to match_fixture "integration/#{fixture}"
      end

    end
  end
end
