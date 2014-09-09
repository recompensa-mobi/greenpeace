require 'greenpeace/configuration/key'
require 'greenpeace/configuration/type'
require 'greenpeace/configuration/doc'
require 'greenpeace/configuration/default'
require 'greenpeace/configuration/requirement'
require 'greenpeace/configuration/option'

module Greenpeace
  module Configuration
    #
    # = Config
    #
    # This class exposes the API methods that the end user can call on a
    # `Greenpeace.configure` block.
    #
    # == Requirements
    #
    # Requirements are definition of environment keys which MUST be present on
    # application startup. When a requirement is defined, if the environment
    # key is not present and the current runtime mode does not have a specific
    # default for the key an error is raised.
    #
    # The API is like the following:
    #
    #   env.requires :key,
    #     type: TYPE,
    #     doc: DOC,
    #     defaults: DEFAULTS
    #
    # This defines a required value on ENV['KEY']. Everything after the key is
    # absolutely optional:
    #
    # * TYPE: Type to convert the env value to. May be either :string or :int.
    # :string by default.
    #
    # * DOC: Doc string which will be used when raising the exception if the
    # environment value is not present. Extremely useful to make your
    # application self-describing.
    #
    # * DEFAULTS: Hash which defines special defaults to use when the
    # environment value is not present on a specific runtime mode. For example,
    # if you want an entry to raise an error on production, but default to a
    # given value on development, you declare a requirement like this:
    #
    #   env.requires :port, type: :int, defaults: { development: 3000 }
    #
    # == Options
    #
    # Options are definition of environment keys which may or may not be
    # present on application startup. Think of them as configurable optional
    # values. When an option is defined, the environment value is used first,
    # if any. If not, a default value is provided instead.
    #
    # The API is like this:
    #
    #   env.may_have :key,
    #     type: TYPE,
    #     doc: DOC,
    #     default: DEFAULT,
    #     defaults: DEFAULTS
    #
    # The TYPE, DOC and DEFAULTS options work just like in the case of
    # requirements. The main difference is in the DEFAULT value, which is used
    # if no value is present in the environment, and no default is defined in
    # the DEFAULTS entry for the current runtime mode. By default, if no value
    # is present in the environment hash, no value is provided in the DEFAULT
    # option and no value is provided in the DEFAULTS option for the current
    # runtime environment, nil is returned.
    class Config
      attr_reader :settings

      def initialize(environment = '')
        @settings = []
        @environment = environment
      end

      def requires(key, options = {})
        requirement = Greenpeace::Configuration::Requirement.new(
          key,
          options,
          @environment)

        add_setting_uniquely(requirement)
      end

      def may_have(key, options = {})
        option = Greenpeace::Configuration::Option.new(
          key,
          options,
          @environment)

        add_setting_uniquely(option)
      end

      private

      def add_setting_uniquely(setting)
        if key_already_defined?(setting.key)
          fail "Duplicated configuration key #{setting.key}"
        end
        @settings << setting
      end

      def key_already_defined?(key)
        @settings.any? { |setting| setting.key == key }
      end
    end
  end
end
