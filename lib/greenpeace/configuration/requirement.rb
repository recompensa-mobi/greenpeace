module Greenpeace::Configuration
  class Requirement
    attr_reader :key
    attr_reader :type
    attr_reader :doc

    def initialize(key, options)
      @key = Greenpeace::Configuration::Key.new(key)
      @type = Greenpeace::Configuration::Type.new(options, :type)
      @doc = Greenpeace::Configuration::Doc.new(options, :doc)
    end

    def identifier
      @key.identifier
    end

    def value
      value = ENV[@key.env_identifier]
      if value.nil? or value.empty?
        raise "Environment key [#{@key}] is missing. The key documentation: #{@doc}"
      end

      @type.convert(value)
    end
  end
end
