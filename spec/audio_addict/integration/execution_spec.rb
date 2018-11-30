require 'spec_helper'

describe 'integration::execution' do
  subject { AudioAddict::CLI.router }

  commands = [
    %w[],
    %w[status],
    %w[status --help],
    %w[status --unsafe],
    %w[channels deep],
    %w[channels --help],
    %w[set --help],
    %w[set ebm di],
  ]

  it "works" do
    commands.each do |command|
      say "  > !txtpur!radio #{command.join ' '}!txtrst!".strip
      fixture_id = command.join(' ')
      fixture_id = "empty" if fixture_id.empty?
      expect{ subject.run command }.to output_fixture "integration/#{fixture_id}"
    end
  end
end
