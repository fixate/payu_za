module PayuZa
  module Structs
    class Transaction
      include StructModel

      field :Api, default: 'ONE_ZERO'
      field :SafeKey, default: -> { PayuZa.safe_key }
      field :TransactionType, required: true
      field :AuthenticationType, required: true
      field :storePaymentMethod
      field :AdditionalInformation, required: true
      field :Basket, required: true
      field :Customer
      field :Creditcard
      field :Loyalty
    end
  end
end
