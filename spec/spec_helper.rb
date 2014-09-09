require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

def configure_env_value(value)
  ENV['KEY'] = value
end
