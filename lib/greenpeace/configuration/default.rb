module Greenpeace
  module Configuration
    # Defines a default setting in a requirement or option
    class Default
      def initialize(type, options, key, plural_key)
        @type = type

        @has_direct_value = options.key?(key)
        @direct_value = extract_direct_value(options, key)

        @has_environment_value = options.key?(plural_key)
        @environment_values = extract_environment_value(options, plural_key)
      end

      def value(environment)
        if @has_direct_value
          @direct_value
        elsif @has_environment_value
          @environment_values[environment.to_s]
        else
          nil
        end
      end

      def environment_value?(environment)
        @has_environment_value && @environment_values[environment.to_s]
      end

      private

      def validate_environment_hash(hash)
        hash.keys.each_with_object({}) do |key, result|
          result[key.to_s] = validate_default(hash[key])
        end
      end

      def validate_default(value)
        unless @type.valid_value?(value)
          fail "Default value #{value}" \
            " is not of the corresponding type #{@type}"
        end
        value
      end

      def extract_direct_value(options, key)
        validate_default(options[key]) if @has_direct_value
      end

      def extract_environment_value(options, plural_key)
        validate_environment_hash(options[plural_key]) if @has_environment_value
      end
    end
  end
end
