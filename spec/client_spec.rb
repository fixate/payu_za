require 'spec_helper'

RSpec.describe PayuZa::Client, stub_requests: true do
  describe '#operations' do
    before { described_class.send(:public, :client) }

    it 'calls operations on the savon client' do
      expect(subject.client).to receive(:operations)
      subject.operations
    end
  end
end
