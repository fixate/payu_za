module PayuZa
  class Client
    def operations
      client.operations
    end

    def respond_to?(method)
      super || operations.include?(method)
    end

    def method_missing(method, *args, &block)
      if operations.include?(method)
        client.call(method, *args)
      else
        super
      end
    end

    private

    def client
      @client ||= Savon.client(
        wsdl: PayuZa.wsdl_endpoint,
        headers: authentication_header
      )
    end

    def authentication_header
      { wsse_auth: [PayuZa.soap_username, PayuZa.soap_password, :digest] }
    end
  end
end
