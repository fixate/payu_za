module PayuZa
  module Structs
    module StructModel

      def self.included(base)
        base.send(:extend, ClassMethods)
      end

      def valid?
        validate! rescue false
      end

      def validate!
        self.class.fields.each do |name, options|
          if options[:required] && send(name).nil?
            raise StructNotValidError.new(name, 'is required')
          end
        end
      end

      def to_hash
        vars_to_hash
      end

      def operation_name
        @operation_name ||= self.class.name.split('::').last.underscore.to_sym
      end

      private

      def vars_to_hash
        hash = {}
        self.class.fields.each do |name, _options|
          value = send(name)
          next if value.nil?
          hash[name.to_s] = hash_value(value)
        end
        hash
      end

      def hash_value(value)
        if value.respond_to?(:to_hash)
          value.to_hash
        elsif value.is_a?(Array)
          value.map do |v|
            hash_value(v)
          end
        else
          value
        end
      end

      def default_for(field)
        default = self.class.fields[field][:default]
        if default.respond_to?(:call)
          default.arity > 0 ?  default.call(self) : default.call
        else
          default
        end
      end

      module ClassMethods
        def field(name, options = {})
          fields[name] = options

          define_method name do
            instance_variable_get(:"@#{name}") || default_for(name)
          end

          define_method "#{name}=" do |value|
            instance_variable_set(:"@#{name}", value)
          end
        end

        def create(attributes)
          new.tap do |struct|
            attributes.each do |name, value|
              struct.send("#{name}=", value)
            end
          end
        end

        def fields
          @fields ||= {}
        end
      end
    end
  end
end
