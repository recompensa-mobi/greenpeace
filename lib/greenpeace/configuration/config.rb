require "greenpeace/configuration/key"
require "greenpeace/configuration/type"
require "greenpeace/configuration/doc"
require "greenpeace/configuration/default"
require "greenpeace/configuration/requirement"
require "greenpeace/configuration/option"

class Greenpeace::Configuration::Config
  attr_reader :requirements
  attr_reader :options

  def initialize
    @requirements = []
    @options = []
  end

  def requires(key, options={})
    requirement = Greenpeace::Configuration::Requirement.new(key, options)
    add_requirement(requirement)
  end

  def may_have(key, options={})
    option = Greenpeace::Configuration::Option.new(key, options)
    add_option(option)
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

  def key_already_defined?(key)
    @requirements.any? {|item| item.key == key} ||
      @options.any? {|item| item.key == key}
  end
end
