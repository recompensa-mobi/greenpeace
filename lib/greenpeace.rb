require "greenpeace/railtie" if defined?(Rails)
require "greenpeace/configuration/config"
require "greenpeace/environment"

module Greenpeace
  def self.configure
    configuration = Greenpeace::Configuration::Config.new
    yield configuration
    @@env = Greenpeace::Environment.new(configuration)
  end

  def self.env
    @@env
  end
end

