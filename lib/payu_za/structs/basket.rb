module PayuZa
  module Structs
    class Basket
      include StructModel

      field :description, required: true
      field :amountInCents, required: true
      field :currencyCode, required: true
    end
  end
end
