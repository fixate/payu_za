module PayuZa
  module Structs
    class Customer
      include StructModel

      field :firstName
      field :lastName
      field :regionalId
      field :mobile
      field :email
      field :merchantUserId
      field :DOB
    end
  end
end
