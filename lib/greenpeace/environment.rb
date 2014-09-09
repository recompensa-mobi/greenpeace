module Greenpeace
  # Environment accessor object
  class Environment
    attr_reader :values

    def initialize(config)
      @values = {}

      config.settings.each do |setting|
        @values[setting.identifier] = setting.value
      end
    end

    def method_missing(method)
      value = method.to_s
      if @values.key?(value)
        @values[value]
      else
        super
      end
    end
  end
end
