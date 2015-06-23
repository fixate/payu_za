module PayuZa
  class Client
    def operations
      client.operations
    end

    private

    def client
      @client ||= Savon.client(wsdl: PayuZa.wsdl_endpoint)
    end
  end
end
