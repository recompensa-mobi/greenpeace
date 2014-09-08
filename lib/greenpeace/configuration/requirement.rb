require "greenpeace/configuration/key"
require "greenpeace/configuration/type"
require "greenpeace/configuration/doc"
require "greenpeace/configuration/default"

module Greenpeace::Configuration
  class Requirement
    attr_reader :key

    def initialize(key, options, environment)
      @environment = environment
      @key = Greenpeace::Configuration::Key.new(key)
      @type = Greenpeace::Configuration::Type.new(options, :type)
      @doc = Greenpeace::Configuration::Doc.new(options, :doc)
      @default = Greenpeace::Configuration::Default.new(
        @type,
        options,
        nil,
        :defaults)
    end

    def identifier
      @key.identifier
    end

    def value
      value = ENV[@key.env_identifier]

      if value.nil? or value.empty?
        if @default.has_environment_value?(@environment)
          @default.value(@environment)
        else
          raise "Environment key [#{@key}] is missing. The key documentation: #{@doc}"
        end
      else
        @type.convert(value)
      end
    end
  end
end
