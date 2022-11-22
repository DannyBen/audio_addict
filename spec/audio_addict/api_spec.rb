require 'spec_helper'

describe API do
  require_mock_server!

  subject { described_class.new 'di' }

  context 'when an API error occurs' do
    it 'raises an error' do
      expect { subject.get 'no-such-route' }.to raise_error(APIError)
    end
  end
end
