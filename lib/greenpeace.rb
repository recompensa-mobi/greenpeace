require 'greenpeace/railtie'
require 'greenpeace/version'
require 'greenpeace/configuration/config'
require 'greenpeace/environment'

#
# = Greenpeace
#
# Greenpeace is an environment checker for validating the environment
# configuration values before starting your application. The Greenpeace module
# works as the only point of contact and API with users of the library, for
# both defining environment requirements and accessing the environment values
# on runtime.
#
# == Configuring requirements
#
# Before starting your application, you need to define what you need in your
# environment. To do this, you call the `configure` method, using the
# requirements API to define what is needed (called requirements in Greenpeace
# docs) and what may be provided (called options in Greenpeace docs):
#
#   Greenpeace.configure do |env|
#     # Here you define your environment values
#   end
#
# You can also pass in an optional environment which represents the current
# runtime mode the application is running into. This is useful for defining
# runtime mode-specific defaults, such as default values which are applied only
# in development mode.
#
#   Greenpeace.configure(ENV['RAILS_ENV']) do |env|
#     # Here you define your environment values. Any defaults which you define
#     # here that match with the runtime mode in the RAILS_ENV value will be
#     # applied.
#   end
#
# Check the grenpeace/configuration/config file for additional documentation on
# how the requirements and option API is used.
#
# == Accessing environment values
#
# You can access the environment values directly through the `Greenpeace.env`
# object. This will provide accessor methods according to what you defined in
# the configuration block above.
#
# For example, if you had a configuration block like the following:
#
#   Greenpeace.configure do |env|
#     env.requires :database_url
#
#     env.requires :port, type: :int
#   end
#
# Then you could access the following variables:
#
#   Greenpeace.env.database_url
#   Greenpeace.env.port
#
# The main advantage over using the standard `ENV` hash is that Greenpeace
# performs type conversion. In the previous example, the `Greenpeace.env.port`
# method returns an integer, not a string.
module Greenpeace
  class << self
    attr_reader :env

    def configure(environment = 'production')
      configuration = Greenpeace::Configuration::Config.new(environment)
      yield configuration
      @env = Greenpeace::Environment.new(configuration)
    end
  end
end
