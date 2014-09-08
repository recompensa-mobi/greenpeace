module Greenpeace::Configuration
  class Default
    def initialize(type, options, key, plural_key)
      @type = type

      @has_direct_value = options.has_key?(key)
      @direct_value = @has_direct_value ?
        validate_default(options[key]) :
        nil

      @has_environment_value = options.has_key?(plural_key)
      @environment_values = @has_environment_value ?
        validate_environment_hash(options[plural_key]) :
        nil
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

    def has_environment_value?(environment)
      @has_environment_value && @environment_values[environment.to_s]

    end

    private
    def validate_environment_hash(hash)
      hash.keys.inject({}) do |result, key|
        result[key.to_s] = validate_default(hash[key])
        result
      end
    end

    def validate_default(value)
      unless @type.valid_value?(value)
        raise "Default value #{value} is not of the corresponding type #{@type}"
      end
      value
    end
  end
end
