module Greenpeace
  class Environment
    attr_reader :values

    def initialize(config)
      @values = {}

      config.requirements.each do |requirement|
        @values[requirement.identifier] = requirement.value
      end

      config.options.each do |option|
        @values[option.identifier] = option.value
      end
    end

    def method_missing(method)
      value = method.to_s
      if @values.has_key?(value)
        @values[value]
      else
        super
      end
    end
  end
end
