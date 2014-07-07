module Greenpeace::Configuration
  class Option
    attr_reader :key
    attr_reader :type
    attr_reader :doc
    attr_reader :default

    def initialize(key, options)
      @key = Greenpeace::Configuration::Key.new(key)
      @type = Greenpeace::Configuration::Type.new(options, :type)
      @doc = Greenpeace::Configuration::Doc.new(options, :doc)
      @default = Greenpeace::Configuration::Default.new(@type, options, :default)
    end

    def identifier
      @key.identifier
    end

    def value
      value = ENV[@key.env_identifier]
      if value.nil? or value.empty?
        @default.value
      else
        @type.convert(value)
      end
    end
  end
end
