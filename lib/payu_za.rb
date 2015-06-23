require 'savon'

require "payu_za/version"
require "payu_za/client"

module PayuZa
  extend self

  attr_accessor :wsdl_endpoints, :environment, :soap_username, :soap_password

  def configure
    yield self
  end

  def default!
    PayuZa.configure do |config|
      config.wsdl_endpoints = {
        development: 'https://staging.payu.co.za/service/PayUAPI?wsdl',
        staging: 'https://staging.payu.co.za/service/PayUAPI?wsdl',
        production: 'https://secure.payu.co.za/service/PayUAPI?wsdl'
      }

      config.environment = :production
    end
  end

  def wsdl_endpoint
    wsdl_endpoints[environment]
  end
end

PayuZa.default!

