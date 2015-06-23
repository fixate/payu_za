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
        client.call(method, message: message(*args))
      else
        super
      end
    end

    def request(name, message)
      client.operation(name).request(message: message(message))
    end

    def message(message = {})
      PayuZa.default_message.merge(message)
    end

    def client
      @client ||= Savon.client(
        wsdl: PayuZa.wsdl_endpoint,
        wsse_auth: wsse_auth
      )
    end

    private

    def wsse_auth
      [PayuZa.soap_username, PayuZa.soap_password, PayuZa.password_digest]
    end
  end
end
