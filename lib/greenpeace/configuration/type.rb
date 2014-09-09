module Greenpeace
  module Configuration
    # Represents a type entry in a requirement or option. In charge of
    # validating values and converting them to the appropriate type.
    class Type
      TYPES = {
        string: {
          converter: :to_s,
          typeclass: String,
          regexp: /.*/
        },

        int: {
          converter: :to_i,
          typeclass: Integer,
          regexp: /^\d+$/
        }
      }

      def initialize(options, key)
        @type = options.key?(key) ? validate_type(options[key]) : :string
      end

      def valid_value?(value)
        value.nil? || value.is_a?(type_descriptor[:typeclass])
      end

      def convert(value)
        unless value.nil? || value.match(type_descriptor[:regexp])
          fail "Value #{value} is supposed to be a #{@type}"
        end

        value.send(type_descriptor[:converter])
      end

      def to_s
        @type.to_s
      end

      private

      def type_descriptor
        TYPES[@type]
      end

      def validate_type(type)
        fail 'Type cannot be nil' if type.nil?
        fail 'Type must be a symbol' unless type.is_a?(Symbol)
        unless TYPES.key?(type)
          fail "Type #{type} must be one of #{TYPES.keys.join(', ')}"
        end
        type
      end
    end
  end
end
