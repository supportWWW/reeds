# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'
ENV['RAILS_ENV'] ||= 'development'
# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  config.frameworks -= [ :active_resource ]

  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "aws-s3", :lib => "aws/s3"

  config.gem 'will_paginate', :version => '2.2.2'
  config.gem 'RedCloth', :version => '3.0.4', :lib => 'redcloth'
  config.gem 'gchartrb', :version => '0.8', :lib => 'google_chart'
  config.gem 'fastercsv', :version => '1.2.3'
  config.gem 'money', :version => '2.1.4'
  config.gem 'mailbuild', :version => '1.1.2'
  config.gem 'uuidtools', :version => '1.0.3'
  config.gem 'jcnetdev-active_record_without_table', :lib => 'active_record_without_table', :version => '1.1'
  
  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )
  config.load_paths += %W(  #{RAILS_ROOT}/app/mailers
                            #{RAILS_ROOT}/app/observers
                            #{RAILS_ROOT}/app/services
                            #{RAILS_ROOT}/app/form_models
                            #{RAILS_ROOT}/vendor/gems/uuidtools-1.0.3/lib
                            #{RAILS_ROOT}/vendor/gems/mailbuild-1.0/lib
                          )
  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Uncomment to use default local time.
  config.time_zone = 'Pretoria'

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_reeds_session',
    :secret      => '447841dc99e061e5fdd3d021f061401d47b0816e86743067d4b567a1753ed36c58079f51d31278235f17dfb7df3a6bf4b211f6e275899c2a64d6cb8b1d2137b4'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector
end

# Needed for ImageScience
if RAILS_ENV == "production" 
  ENV['INLINEDIR'] = RAILS_ROOT + "/tmp" 
end
