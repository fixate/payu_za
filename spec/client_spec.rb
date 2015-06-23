require 'spec_helper'

RSpec.describe PayuZa::Client, stub_requests: true do
  before { described_class.send(:public, :client) }

  describe '#operations' do
    it 'calls operations on the savon client' do
      expect(subject.client).to receive(:operations)
      subject.operations
    end
  end

  describe '#respond_to?' do
    it 'responds to wsdl do_transaction method' do
      expect(subject).to respond_to(:do_transaction)
    end
  end

  describe '#method_missing' do
    it 'calls the client' do
      expect(subject.client).to receive(:call).with(:do_transaction, 'test')
      subject.do_transaction('test')
    end
  end
end

