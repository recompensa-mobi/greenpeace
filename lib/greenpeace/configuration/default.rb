module Greenpeace::Configuration
  class Default
    attr_reader :value

    def initialize(type, options, key)
      @type = type
      @value = options.has_key?(key) ? validate_default(options[key]) : nil
    end

    private
    def validate_default(value)
      unless @type.valid_value?(value)
        raise "Default value #{value} is not of the corresponding type #{@type}"
      end
      value
    end
  end
end
