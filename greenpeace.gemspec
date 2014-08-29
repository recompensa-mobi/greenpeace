$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "greenpeace/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "greenpeace"
  s.version     = Greenpeace::VERSION
  s.authors     = ["Andres Arana"]
  s.email       = ["andres.arana@recompensa.mobi"]
  s.homepage    = "https://github.com/recompensa-mobi/greenpeace"
  s.summary     = "Rails engine which checks and sanitizes your environment variables."
  s.description = "Rails engine which checks and sanitizes you environment variables, raising exception if required variables are not configured, type-casting non-string variables and exposing them using the standard rails configuration API."
  s.license     = "MIT"

  s.files = Dir["{lib}/**/*", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency "rails", "~> 4.0"
end
