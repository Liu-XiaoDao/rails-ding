module Rails
  module Ding
    class AuthService

      def self.configuration
        Ding::configuration
      end

      def self.getAccessToken
         # 缓存accessToken。accessToken有效期为两小时，需要在失效前请求新的accessToken（注意：以下代码没有在失效前刷新缓存的accessToken）。
        accessToken = CacheService::getCorpAccessToken()
        if accessToken.blank?
          response = HttpService.get('/gettoken?', {corpid: configuration.corpid, corpsecret: configuration.secret})
          check(response)
          accessToken = response['access_token']
          CacheService::setCorpAccessToken(accessToken)
        end
        return accessToken
      end


      def self.getTicket(accessToken)
        jsticket = CacheService::getJsTicket()
        if jsticket.blank?
          response = HttpService.get('/get_jsapi_ticket?', {type: 'jsapi', access_token: accessToken})
          check(response)
          jsticket = response['ticket']
          CacheService::setJsTicket(jsticket)
        end
        return jsticket
      end

      def self.getConfig(href)
        corpId = configuration.corpid
        agentId = configuration.agentid
        nonceStr = 'abcdefg'
        timeStamp = Time.now.to_i
        url = href
        corpAccessToken = getAccessToken()
        if corpAccessToken.blank?
           LogService.e("[getConfig] ERR: no corp access token")
        end
        ticket = getTicket(corpAccessToken)
        signature = sign(ticket, nonceStr, timeStamp, url)

        config = {'url' => url,'nonceStr' => nonceStr,'agentId' => agentId, 'timeStamp' => timeStamp, 'corpId' => corpId, 'signature' => signature}
        return config
      end

      def self.sign(ticket, nonceStr, timeStamp, url)
        plain = "jsapi_ticket=#{ticket}&noncestr=#{nonceStr}&timestamp=#{timeStamp}&url=#{url}"
        return Digest::SHA1.hexdigest(plain);
      end

      def self.check(res)
        if res["errcode"] != 0
          LogService.e("FAIL: #{res.to_json}")
        end
      end

    end
  end
end
