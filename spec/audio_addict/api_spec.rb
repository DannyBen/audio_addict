require 'spec_helper'

describe API do
  require_mock_server!

  subject { described_class.new 'di' }

  context "on api error" do
    it "raises an error" do
      expect { subject.get 'no-such-route' }.to raise_error(APIError)
    end
  end
end
