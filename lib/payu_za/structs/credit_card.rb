module PayuZa
  module Structs
    class CreditCard
      include StructModel

      field :pmId
      field :cardNumber
      field :cardExpiry
      field :cvv
      field :nameOnCard
      field :budgetPeriod
      field :amountInCents, required: true
    end
  end
end
