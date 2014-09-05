require "greenpeace/configuration/key"
require "greenpeace/configuration/type"
require "greenpeace/configuration/doc"
require "greenpeace/configuration/default"
require "greenpeace/configuration/requirement"
require "greenpeace/configuration/option"

module Greenpeace::Configuration
  class Config
    attr_reader :settings

    def initialize
      @settings = []
    end

    def requires(key, options={})
      requirement = Greenpeace::Configuration::Requirement.new(key, options)
      add_setting_uniquely(requirement)
    end

    def may_have(key, options={})
      option = Greenpeace::Configuration::Option.new(key, options)
      add_setting_uniquely(option)
    end

    private
    def add_requirement(requirement)
      if key_already_defined?(requirement.key)
        raise "Requirement key #{requirement.key} must be uniquely defined"
      end
      @requirements << requirement
    end

    def add_option(option)
      if key_already_defined?(option.key)
        raise "Option key #{option.key} must be uniquely defined"
      end
      @options << option
    end

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
