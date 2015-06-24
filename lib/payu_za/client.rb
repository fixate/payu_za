module PayuZa
  class Client
    def operations
      client.operations
    end

    # execute(:method, {my: 'message'}|Struct)
    # or
    # execute(Struct)
    def execute(*args)
      if args.length > 1
        operation_name, struct = args
      else
        struct = args.first
        operation_name = struct.operation_name
      end

      message = struct.respond_to?(:to_hash) ? struct.to_hash : struct

      client.call(operation_name, message: message)
    end

    def new_struct(name, attributes = {})
      klass = name.to_s.camelize
      "PayuZa::Structs::#{klass}".constantize.create(attributes)
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
