module Greenpeace
  module Configuration
    # Represents a doc configuration in a requirement
    class Doc
      def initialize(options, key)
        @doc = options.key?(key) ? validate_doc(options[key]) : 'Undefined'
      end

      def to_s
        @doc
      end

      private

      def validate_doc(doc)
        fail 'Doc cannot be nil' if doc.nil?
        fail 'Doc must be a string' unless doc.is_a?(String)
        doc
      end
    end
  end
end
