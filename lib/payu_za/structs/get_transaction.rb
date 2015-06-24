module PayuZa
  module Structs
    class GetTransaction
      include StructModel

      field :Api, default: 'ONE_ZERO'
      field :SafeKey, default: -> { PayuZa.safe_key }
      field :payUReference
      field :merchantReference
    end
  end
end
