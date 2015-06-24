require 'spec_helper'

RSpec.describe PayuZa::Client, stub_requests: true do
  let(:transaction) { fixture_struct(:do_transaction) }

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
      expect(subject.client).to receive(:call)
        .with(:do_transaction, message: transaction.to_hash)
      subject.do_transaction(transaction)
    end
  end

  describe '#request' do
    subject do
      described_class.new
        .request(:do_transaction, transaction)
    end

    it 'contains wsse header' do
      expect(subject.body).to include('<wsse:Security')
    end

    it 'contains wsse user name token' do
      expect(subject.body).to include('<wsse:UsernameToken')
    end

    it 'contains wsse user name' do
      PayuZa.soap_username = 'test123'
      expect(subject.body).to include('<wsse:Username>test123</wsse:Username>')
    end

    it 'contains wsse user password' do
      expect(subject.body).to include('<wsse:Password')
    end
  end
end
