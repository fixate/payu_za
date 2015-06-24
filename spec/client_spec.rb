require 'spec_helper'

RSpec.describe PayuZa::Client, stub_requests: true do
  let(:transaction) { fixture_struct(:get_transaction) }

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
    it 'calls the clients call function' do
      expect(subject.client).to receive(:call)
        .with(:do_transaction, message: transaction.to_hash)
      subject.do_transaction(transaction)
    end

    it 'returns a savon response' do
      response = subject.get_transaction(transaction)
      expect(response).to be_kind_of(Savon::Response)
    end
  end

  describe '#request' do
    subject do
      described_class.new
        .request(:get_transaction, transaction)
    end

    context 'Check SOAP Security Header' do
      # TODO: we should probably parse this as xml and check the resulting document
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
end
