# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# config.factory_bot.definition_file_paths = ["custom/factories"]
# Disable serving static files from the `/public` folder by default since
# Apache or NGINX already handles this.
config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present? || ENV['RENDER'].present?
