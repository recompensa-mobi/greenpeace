if defined?(Rails)
  module Greenpeace
    # Railtie which hooks into the Rails initialization process to load the
    # greenpeace configuration file and check for the environment before
    # starting the rest of the application
    class Railtie < ::Rails::Railtie
      config.before_configuration do
        path = ::Rails.root.join('config', 'greenpeace.rb')

        require path if File.exist?(path)
      end
    end
  end
end
