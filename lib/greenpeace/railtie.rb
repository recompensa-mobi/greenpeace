module Greenpeace
  class Railtie < ::Rails::Railtie
    config.before_configuration do
      path = ::Rails.root.join("config", "greenpeace.rb")

      if File.exists?(path)
        require path
      end

      Greenpeace.env.values.each do |key, value|
        config.send("#{key}=", value)
      end
    end
  end
end
