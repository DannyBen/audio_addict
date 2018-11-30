require 'spec_helper'

describe 'command line execution' do
  subject { AudioAddict::CLI.router }

  commands = [
    { cmd: "" },
    { cmd: "status" },
    { cmd: "status --help" },
    { cmd: "status --unsafe" },
    { cmd: "login", kbd: ['n'] },
    { cmd: "login", kbd: ['y', 'user', 'password'] },
    { cmd: "set --help" },
    { cmd: "set dance di" },
    { cmd: "channels" },
    { cmd: "channels tran" },
    { cmd: "channels --help" },
    { cmd: "now" },
    { cmd: "now --help" },
  ]

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

      argv = command.split ' '
      output = interactive *keyboard do
        subject.run argv
      end
      expect(output).to match_fixture "integration/#{fixture}"
    end
  end
end
