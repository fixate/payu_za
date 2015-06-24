# PayuZa

PayU ZA Enterprise SOAP API integration

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'payu_za'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install payu_za

## Usage

### Initializer

```ruby
PayUZa.configure do |c|
  c.soap_username = ENV['PAYU_SOAP_USERNAME']
  c.soap_password = ENV['PAYU_SOAP_PASSWORD']
  c.safe_key = ENV['PAYU_SAFE_KEY']
  # Be sure to set your environment to :production in prod - defaults to :staging
  c.environment = :production # or :staging or Rails.env.to_sym

  # Other configuration
  # Set the default api version (can be overriden per request)
  # c.api_version = "ONE_ZERO"
  #
  # Set password_digest to true to prevent your password being sent in clear text
  # Defaults to false because not sure if PayU supports wsse password digest
  # c.password_digest = true
  #
  # Set your own wsdls - not sure why anyone would ever need this
  # c.wsdl_endpoints = {
  #    development: 'https://localhost:12345/?wsdl',
  #    production: 'https://my-proxy.com/wsdl'
  # }
end
```

### DoTransaction Example

```ruby
client = PayUZa::Client.new

additional_info = client.new_struct(:additional_information, {
  merchantReference: '12345',
  payUReference: 'abcdefg1234'
})

transaction = client.new_struct(:do_transaction, {
  TransactionType: PayUZa::Structs::TRANSACTION_TYPE::PAYMENT,
  AuthenticationType: PayUZa::Structs::AUTHENTICATION_TYPE::NA,
  AdditionalInformation: additional_info
  # etc ...
})

# Object style
creditcard = client.new_struct(:credit_card)
creditcard.cardNumber = '4242424242424242'
creditcard.cardExpiry = '122013'

transaction.Creditcard = creditcard

response = client.execute(transaction)
# or you can pass in a hash
response = client.execute(:do_transaction, {
  Api: 'ONE_ZERO',
  SafeKey: '12345'
  # ...
})

```

Supports `do_transaction`, `set_transaction` and `get_transaction`

## Contributing

1. Fork it ( https://github.com/fixate/payu_za/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
