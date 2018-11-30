require 'spec_helper'

describe 'command line execution' do
  subject { AudioAddict::CLI.router }

  commands = YAML.load_file 'spec/audio_addict/commands.yml'
  commands = commands[:commands]

  # TODO: We probably dont need to test anything against the live server
  #       so base_uri stuff should move to a helper and executed once only
  let(:mock_api_base) { "http://localhost:3000" }
  let(:live_api_base) { 'https://api.audioaddict.com/v1' }

  commands.each do |spec|
    command = spec[:cmd]
    keyboard = spec[:kbd]
    live = spec[:live]

    it "works: #{command}" do
      AudioAddict::API.base_uri live ? live_api_base : mock_api_base

      test_name = "#{command}"
      test_name = "#{command} (#{keyboard.join ' '})" if keyboard

      fixture = test_name
      fixture = "empty" if fixture.empty?
      fixture.gsub!(/[^a-zA-Z\- \(\)]/, '')

      argv = command.split ' '
      output = interactive *keyboard do
        subject.run argv
      end
      expect(output).to match_fixture "integration/#{fixture}"
    end
  end
end
