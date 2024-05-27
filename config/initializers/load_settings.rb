# config/initializers/load_settings.rb
require 'yaml'

settings = YAML.load_file(Rails.root.join('config', 'settings.yml'))
Rails.configuration.x.settings = settings[Rails.env] || settings['default']
