require "rails/ding/engine"
require "rails/ding/configuration"
require "rails/ding/http_service"
require "rails/ding/log_service"
require "rails/ding/cache_service"
require "rails/ding/auth_service"
require "rails/ding/chat_service"
require "rails/ding/department_service"
require "rails/ding/message_service"
require "rails/ding/user_service"
require "rails/ding/attendance_service"

begin
  require "pry"
rescue LoadError
end

module Rails
  module Ding
    class << self
      attr_writer :configuration
    end

    def self.configuration
      @configuration ||= Rails::Ding::Configuration.new
    end

    def self.reset
      @configuration = Rails::Ding::Configuration.new
    end

    def self.configure
      yield(configuration)
    end
  end
end
