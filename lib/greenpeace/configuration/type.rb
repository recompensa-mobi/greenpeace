module Greenpeace::Configuration
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
        regexp: /\d+/
      },
    }

    def initialize(options, key)
      @type = options.has_key?(key) ? validate_type(options[key]) : :string
    end

    def valid_value?(value)
      value.nil? or value.is_a?(type_descriptor[:typeclass])
    end

    def convert(value)
      unless value.match(type_descriptor[:regexp])
        raise "Value #{value} is supposed to be a #{@type}"
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
      raise "Type cannot be nil" if type.nil?
      raise "Type must be a symbol" unless type.is_a?(Symbol)
      unless TYPES.has_key?(type)
        raise "Type #{type} must be one of #{TYPES.keys.join(", ")}"
      end
      type
    end
  end
end
