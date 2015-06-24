module PayuZa
  module Structs
    class DoTransaction
      include StructModel

      field :Api, default: 'ONE_ZERO'
      field :SafeKey, default: -> { PayuZa.safe_key }
    end
  end
end
