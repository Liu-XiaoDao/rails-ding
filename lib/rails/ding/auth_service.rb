module Rails
  module Ding
    class AuthService

      def initialize
        @http = HttpService.new
        @cache = RedisService.new
        @config = YAML.load( File.read(Rails.root.to_s + "/config/dingconfig.yml"))
      end

      def getAccessToken
         # 缓存accessToken。accessToken有效期为两小时，需要在失效前请求新的accessToken（注意：以下代码没有在失效前刷新缓存的accessToken）。
        accessToken = @cache.getCorpAccessToken()
        if accessToken.blank?
          response = @http.get('/gettoken?', {corpid: @config['corpid'], corpsecret: @config['secret']})
          check(response)
          accessToken = response['access_token']
          @cache.setCorpAccessToken(accessToken)
        end
        return accessToken
      end


      def getTicket(accessToken)
        jsticket = @cache.getJsTicket()
        if jsticket.blank?
          response = @http.get('/get_jsapi_ticket?', {type: 'jsapi', access_token: accessToken})
          check(response)
          jsticket = response['ticket']
          @cache.setJsTicket(jsticket)
        end
        return jsticket
      end

      def getConfig(href)
        corpId = @config['corpid'];
        agentId = @config['agentid'];
        nonceStr = 'abcdefg';
        timeStamp = Time.now.to_i;
        url = href
        corpAccessToken = getAccessToken();
        if corpAccessToken.blank?
           LogService.e("[getConfig] ERR: no corp access token");
        end
        ticket = getTicket(corpAccessToken);
        signature = sign(ticket, nonceStr, timeStamp, url)

        config = {'url' => url,'nonceStr' => nonceStr,'agentId' => agentId, 'timeStamp' => timeStamp, 'corpId' => corpId, 'signature' => signature}
        return config
      end

      def sign(ticket, nonceStr, timeStamp, url)
        plain = "jsapi_ticket=#{ticket}&noncestr=#{nonceStr}&timestamp=#{timeStamp}&url=#{url}"
        return Digest::SHA1.hexdigest(plain);
      end

      def check(res)
        if res["errcode"] != 0
          LogService.e("FAIL: #{res.to_json}")
        end
      end

    end
  end
end
