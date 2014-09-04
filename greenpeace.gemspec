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
  s.summary     = "Check and sanitize your environment variables."
  s.description = "Library which allows you to check and sanitize you environment variables, raising exception if required variables are not configured, type-casting non-string variables and exposing them using an idiomatic API."
  s.license     = "MIT"

  s.files = Dir["{lib}/**/*", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
