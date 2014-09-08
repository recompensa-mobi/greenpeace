require "greenpeace/configuration/key"
require "greenpeace/configuration/type"
require "greenpeace/configuration/doc"
require "greenpeace/configuration/default"
require "greenpeace/configuration/requirement"
require "greenpeace/configuration/option"

module Greenpeace::Configuration
  class Config
    attr_reader :settings

    def initialize(environment = "")
      @settings = []
      @environment = environment
    end

    def requires(key, options={})
      requirement = Greenpeace::Configuration::Requirement.new(
        key,
        options,
        @environment)

      add_setting_uniquely(requirement)
    end

    def may_have(key, options={})
      option = Greenpeace::Configuration::Option.new(
        key,
        options,
        @environment)

      add_setting_uniquely(option)
    end

    private
    def add_setting_uniquely(setting)
      if key_already_defined?(setting.key)
        raise "Duplicated configuration key #{setting.key}"
      end
      @settings << setting
    end

    def key_already_defined?(key)
      @settings.any? {|setting| setting.key == key}
    end
  end
end
