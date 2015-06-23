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
        {
          self.class.root => vars_to_hash
        }
      end

      def to_hash_without_root
        vars_to_hash
      end

      private

      def vars_to_hash
        hash = {}
        self.class.fields.each do |name, _options|
          value = send(name)
          next if value.nil?

          # Allow for nested structs
          hash[name.to_s] = if value.respond_to?(:to_hash_without_root)
            value.to_hash_without_root
          elsif value.respond_to?(:to_hash)
            value.to_hash
          else
            value
          end
        end
        hash
      end

      module ClassMethods
        def field(name, options = {})
          fields[name] = options

          define_method name do
            instance_variable_get(:"@#{name}") || self.class.fields[name][:default]
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

        def root(value = nil)
          if value.nil?
            @root || self.name
          else
            @root = value
          end
        end
      end
    end
  end
end
