# Database configuration for Render.com
if Rails.env.production?
  # Handle database connection issues in production
  Rails.application.configure do
    # Increase database connection timeout
    config.active_record.connection_db_config.configuration_hash[:connect_timeout] = 60
    config.active_record.connection_db_config.configuration_hash[:checkout_timeout] = 60
  end
end