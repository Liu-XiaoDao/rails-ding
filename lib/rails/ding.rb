require "rails/ding/engine"
require "rails/ding/http_service"
require "rails/ding/log_service"
require "rails/ding/cache_service"
begin
  require "pry"
rescue LoadError
end

module Rails
  module Ding
    puts "test"
    Rails::Ding::LogService.e("[getConfig] ERR: no corp access token");
    Rails::Ding::CacheService.setCorpAccessToken('1111')
    puts Rails::Ding::HttpService::get('/gettoken?', {corpid: 'ding4e97ac09cf15a1d2', corpsecret: 'jQOqko0rIUGRSBV4APykM9horY317-7TTtPdmKeyhIjnDPYxkfMMAJnwixllLCBx'})
  end
end
