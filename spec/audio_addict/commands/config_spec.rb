require 'spec_helper'

describe Commands::ConfigCmd do
  subject { CLI.router }

  describe "edit" do
    before { Config.save }

    it "opens the system editor" do
      ENV['EDITOR']='edit'
      expect_any_instance_of(described_class).to receive(:system).with("edit #{Config.path}")
      subject.run ["config", "edit"]
    end
  end
end
