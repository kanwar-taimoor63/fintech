require_relative 'boot'

require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fintech
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    ActionMailer::Base.smtp_settings = {
      address: 'smtp.gmail.com',
      domain:  'mail.google.com',
      port:  587,
      user_name: Rails.application.credentials.email_credentials[:email],
      password:  Rails.application.credentials.email_credentials[:pass],
      authentication:  'login',
      enable_starttls_auto:  true
    }
    config.to_prepare do
      Devise::Mailer.layout 'email'
    end
  end
end
