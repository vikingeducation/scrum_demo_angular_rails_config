require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ScrumDemoAngularRailsConfig
  class Application < Rails::Application

    # ----------------------------------------
    # My Config
    # ----------------------------------------
    config.to_prepare do
      DeviseController.respond_to :html, :json
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
