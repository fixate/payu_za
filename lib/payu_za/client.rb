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
        struct = args.first
        message = struct.is_a?(PayuZa::Structs::StructModel) ?
          struct.to_hash : struct

        client.call(method, message: message)
      else
        super
      end
    end

    def request(name, struct)
      client.operation(name).request(message: struct.to_hash)
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
