module PayuZa
  module Structs
    class DoTransaction
      include StructModel

      module TRANSACTION_TYPE
        RESERVE        = 'RESERVE'
        RESERVE_CANCEL = 'RESERVE_CANCEL'
        PAYMENT        = 'PAYMENT'
        FINALIZE       = 'FINALIZE'
        CREDIT         = 'CREDIT'
      end

      module AUTHENTICATION_TYPE
        NA        = 'NA'
        HANDSHAKE = 'HANDSHAKE'
        TOKEN     = 'TOKEN'
      end

      field :Api, default: 'ONE_ZERO'
      field :SafeKey, default: -> { PayuZa.safe_key }
      field :TransactionType, required: true
      field :AuthenticationType, required: true
      field :storePaymentMethod
      field :AdditionalInfo, required: true
      field :Basket, required: true
      field :Customer
      field :Creditcard
      field :Loyalty
    end
  end
end
