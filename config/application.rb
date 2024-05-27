require_relative "boot"

require "rails/all"
require 'dotenv/load'

Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    config.load_defaults 7.1

    config.autoload_lib(ignore: %w(assets tasks))
    config.autoload_paths += %W(#{config.root}/lib)
    config.eager_load_paths += %W(#{config.root}/lib)
    config.before_configuration do
      config.x.settings = config_for(:settings)
    end
  end
end
