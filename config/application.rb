# coding: utf-8  
require File.expand_path('../boot', __FILE__)
APP_VERSION = '0.6'

require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"


if defined?(Bundler)
  Bundler.require *Rails.groups(:assets => %w(development test))
end


module Homeland
  class Application < Rails::Application
    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
    config.time_zone = 'Beijing'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = "zh-CN"

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password,:password_confirm]
    
    config.mongoid.logger = Logger.new($stdout, :warn)
    
    config.mongoid.include_root_in_json = false
    
    config.assets.enabled = true
    config.assets.version = '1.0'
  end
end

require "daemon"

I18n.locale = 'zh-CN'

# 配置文件载入
APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]

require 'yaml'
YAML::ENGINE.yamler= 'syck'
