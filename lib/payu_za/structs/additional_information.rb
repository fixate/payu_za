module PayuZa
  module Structs
    class AdditionalInformation
      include StructModel

      field :merchantReference, required: true
      field :demoMode
      field :notificationUrl
    end
  end
end
