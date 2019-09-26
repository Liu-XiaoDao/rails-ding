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

begin
  require "pry"
rescue LoadError
end

module Rails
  module Ding
    # puts "test"
    # Rails::Ding::LogService.e("[getConfig] ERR: no corp access token");
    # Rails::Ding::CacheService::setCorpAccessToken('2222')
    # puts Rails::Ding::HttpService::get('/gettoken?', {corpid: 'ding4e97ac09cf15a1d2', corpsecret: 'jQOqko0rIUGRSBV4APykM9horY317-7TTtPdmKeyhIjnDPYxkfMMAJnwixllLCBx'})
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

    # accessToken = AuthService.getAccessToken
    # l = DepartmentService.listDept(accessToken)
    # binding.pry
  end
end
