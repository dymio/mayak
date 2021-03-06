require File.expand_path('../boot', __FILE__)

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# taken from https://github.com/rails/rails/blob/v4.2.8/railties/lib/rails/
#                    generators/rails/app/templates/config/application.rb

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Load libraries from 'lib' folder
require File.expand_path('../../lib/seo.rb', __FILE__)
require File.expand_path('../../lib/static_files_holding.rb', __FILE__)
require File.expand_path('../../lib/url_string_preparator.rb', __FILE__)

module Mayak
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Krasnoyarsk'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ru

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Mark page object as "fixed" by adding his path to array below.
    # Fixed pages protected from hiding, deleting and changing path.
    # Homepage (with empty path) is fixed by default.
    config.fixed_pages_paths = %w(
        news
        feedback
      )
  end
end
