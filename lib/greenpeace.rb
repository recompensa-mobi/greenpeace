require "greenpeace/railtie" if defined?(Rails)
require "greenpeace/configuration/config"
require "greenpeace/environment"

module Greenpeace
  mattr_reader :env

  def self.configure
    configuration = Greenpeace::Configuration::Config.new
    yield configuration
    @@env = Greenpeace::Environment.new(configuration)
  end
end

