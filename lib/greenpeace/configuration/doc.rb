module Greenpeace::Configuration
  class Doc

    def initialize(options, key)
      @doc = options.has_key?(key) ? validate_doc(options[key]) : "Undefined"
    end

    def to_s
      @doc
    end

    private
    def validate_doc(doc)
      raise "Doc cannot be nil" if doc.nil?
      raise "Doc must be a string" unless doc.is_a?(String)
      doc
    end
  end
end
