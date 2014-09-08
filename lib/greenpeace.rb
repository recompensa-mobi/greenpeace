require "greenpeace/railtie" if defined?(Rails)
require "greenpeace/configuration/config"
require "greenpeace/environment"

module Greenpeace
  def self.configure(environment = "production")
    configuration = Greenpeace::Configuration::Config.new(environment)
    yield configuration
    @@env = Greenpeace::Environment.new(configuration)
  end

  def self.clean!
    @@env = nil
  end

  def self.env
    @@env
  end
end

