require 'spec_helper'

RSpec.describe PayuZa do
  describe '.configure' do
    before { described_class.default! }

    it 'sets the accessors' do
      wsdl = {test:'https://blah-blah.com/?wsdl'}
      described_class.configure do |config|
        config.wsdl_endpoints = wsdl
      end

      expect(described_class.wsdl_endpoints).to eq(wsdl)
    end

    it 'sets environment to production by default' do
      expect(described_class.environment).to be(:production)
    end
  end

  describe '.wsdl_endpoint' do
    before do
      described_class.configure do |c|
        c.wsdl_endpoints = {
          test: 'http://123'
        }

        c.environment = :test
      end
    end

    it 'gets the wsdl url by environment' do
      expect(described_class.wsdl_endpoint).to eq('http://123')
    end
  end
end
