# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
OpenMinds::Application.initialize!
#
#
## Be sure to restart your web server when you modify this file.
#
## Uncomment below to force Rails into production mode when
## you don't control web/app server and can't set it the proper way
## ENV['RAILS_ENV'] ||= 'production'
#
## Specifies gem version of Rails to use when vendor/rails is not present
#RAILS_GEM_VERSION = '1.2.6' unless defined? RAILS_GEM_VERSION
#
## Bootstrap the Rails environment, frameworks, and default configuration
#require File.join(File.dirname(__FILE__), 'boot')
#
#Rails::Initializer.run do |config|
#
# # Settings in config/environments/* take precedence over those specified here
#
#  # Skip frameworks you're not going to use (only works if using vendor/rails)
#  # config.frameworks -= [ :action_web_service, :action_mailer ]
#
#  # Only load the plugins named here, by default all plugins in vendor/plugins are loaded
#  # config.plugins = %W( exception_notification ssl_requirement )
#
#  # Add additional load paths for your own custom dirs
#  # config.load_paths += %W( #{RAILS_ROOT}/extras )
#
#  # Force all environments to use the same logger level
#  # (by default production uses :info, the others :debug)
#  # config.log_level = :debug
#
#  # Use the database for sessions instead of the file system
#  # (create the session table with 'rake db:sessions:create')
#  # config.action_controller.session_store = :active_record_store
#
#  # Use SQL instead of Active Record's schema dumper when creating the test database.
#  # This is necessary if your schema can't be completely dumped by the schema dumper,
#  # like if you have constraints or database-specific column types
#  # config.active_record.schema_format = :sql
#
#  # Activate observers that should always be running
#  # config.active_record.observers = :cacher, :garbage_collector
#
#  # Make Active Record use UTC-base instead of local time
#  # config.active_record.default_timezone = :utc
#
#  # Add new inflection rules using the following format
#  # (all these examples are active by default):
#  # Inflector.inflections do |inflect|
#  #   inflect.plural /^(ox)$/i, '\1en'
#  #   inflect.singular /^(ox)en/i, '\1'
#  #   inflect.irregular 'person', 'people'
#  #   inflect.uncountable %w( fish sheep )
#  # end
#
#  # See Rails::Configuration for more options
#  L10N_LANG = :ar
#end
#
## Add new mime types for use in respond_to blocks:
## Mime::Type.register "text/richtext", :rtf
## Mime::Type.register "application/x-mobile", :mobile
#
## Include your application configuration below
#ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(
#  :default => '%d/%m/%y'
#)
# Limpiamos todas las inflecciones existentes
ActiveSupport::Inflector.inflections do |inflect|
  inflect.plural /([aeiou])([A-Z]|_|$)/, '\1s\2'
  inflect.plural /([rlnd])([A-Z]|_|$)/, '\1es\2'
  inflect.plural /([aeiou])([A-Z]|_|$)([a-z]+)([rlnd])($)/, '\1s\2\3\4es\5'
  inflect.plural /([rlnd])([A-Z]|_|$)([a-z]+)([aeiou])($)/, '\1es\2\3\4s\5'
  inflect.singular /([aeiou])s([A-Z]|_|$)/, '\1\2'
  inflect.singular /([rlnd])es([A-Z]|_|$)/, '\1\2'
  inflect.singular /([aeiou])s([A-Z]|_)([a-z]+)([rlnd])es($)/, '\1\2\3\4\5'
  inflect.singular /([rlnd])es([A-Z]|_)([a-z]+)([aeiou])s($)/, '\1\2\3\4\5'

# Se agregan inflectores para todos los casos de detalle_ y detalles_
# Ejs.:
# detalle_pendiente_aprobacion -> detalles_pediente_aprobacion
# detalle_rechazo -> detalles_rechazo
  inflect.plural /(\bdetalle)(\w+|_|$)/, '\1s\2'
  inflect.plural /(\bdetalles)(\w+|_|$)/, '\1\2'
  inflect.singular /(\bdetalle)s(\w+|_|$)/, '\1\2'

  # Para evitar errores de pluralización utilizados por formtastic al utilizar i18n
  # (https://github.com/justinfrench/formtastic/blob/master/lib/formtastic.rb#L1850)
  inflect.irregular 'label', 'labels'
  inflect.irregular 'title', 'titles'
  inflect.irregular 'hint', 'hints'
  inflect.irregular 'action', 'actions'
end