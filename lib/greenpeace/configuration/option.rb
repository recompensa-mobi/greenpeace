require 'greenpeace/configuration/key'
require 'greenpeace/configuration/type'
require 'greenpeace/configuration/doc'
require 'greenpeace/configuration/default'

module Greenpeace
  module Configuration
    # Represents an environment option
    class Option
      attr_reader :key

      def initialize(key, options, environment)
        @environment = environment
        @key = Greenpeace::Configuration::Key.new(key)
        @type = Greenpeace::Configuration::Type.new(options, :type)
        @doc = Greenpeace::Configuration::Doc.new(options, :doc)
        @default = Greenpeace::Configuration::Default.new(
          @type,
          options,
          :default,
          :defaults)
      end

      def identifier
        @key.identifier
      end

      def value
        value = ENV[@key.env_identifier]
        if value.nil? || value.empty?
          @default.value(@environment)
        else
          @type.convert(value)
        end
      end
    end
  end
end
