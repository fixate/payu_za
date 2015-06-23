module PayuZa
  module Structs
    class CustomField
      include StructModel

      field :key, required: true
      field :value, default: ''
    end
  end
end
