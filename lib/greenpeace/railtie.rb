if defined?(Rails)
  module Greenpeace
    class Railtie < ::Rails::Railtie
      config.before_configuration do
        path = ::Rails.root.join("config", "greenpeace.rb")

        if File.exists?(path)
          require path
        end
      end
    end
  end
end
