require 'savon'

require "payu_za/version"
require "payu_za/errors"
require "payu_za/client"
require "payu_za/structs"

module PayuZa
  extend self

  attr_accessor :wsdl_endpoints, :environment, :soap_username, :soap_password,
    :safe_key, :api_version, :password_digest

  def configure
    yield self
  end

  def default!
    PayuZa.configure do |config|
      config.api_version = 'ONE_ZERO'
      config.wsdl_endpoints = {
        development: 'https://staging.payu.co.za/service/PayUAPI?wsdl',
        staging: 'https://staging.payu.co.za/service/PayUAPI?wsdl',
        production: 'https://secure.payu.co.za/service/PayUAPI?wsdl'
      }

      config.environment = :production
    end
  end

  # Set defaults
  default!

  def wsdl_endpoint
    wsdl_endpoints[environment]
  end
end

