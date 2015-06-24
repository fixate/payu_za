require "payu_za/structs/struct_model"
require "payu_za/structs/additional_information"
require "payu_za/structs/customer"
require "payu_za/structs/credit_card"
require "payu_za/structs/basket"
require "payu_za/structs/custom_field"

require "payu_za/structs/transaction"
require "payu_za/structs/get_transaction"
require "payu_za/structs/set_transaction"
require "payu_za/structs/do_transaction"


module PayuZa
  module Structs
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
  end
end
