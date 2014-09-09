module Greenpeace
  module Configuration
    # Represents an environment key in a configuration entry
    class Key
      def initialize(key)
        @key = validate_key(key)
      end

      def ==(other)
        other.key == @key
      end

      def to_s
        @key.to_s
      end

      def identifier
        @key.to_s
      end

      def env_identifier
        @key.to_s.upcase
      end

      protected

      attr_reader :key

      private

      def validate_key(key)
        fail 'Key cannot be nil' if key.nil?
        unless key.is_a? Symbol
          fail "Key #{key} must be a symbol, but was a #{key.class}"
        end
        fail 'Key cannot be blank' if key.empty?
        key
      end
    end
  end
end
