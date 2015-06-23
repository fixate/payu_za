module PayuZa
  class StructNotValidError < StandardError
    attr_reader :var_name

    def initialize(var_name, message)
      @message = "#{var_name} #{message}"
      @var_name = var_name
    end
  end
end
