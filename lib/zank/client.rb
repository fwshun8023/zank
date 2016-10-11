module Zank
  class Client

    attr_accessor :user, :token, :status, :error

    def initialize(username, password)
      @username = username
      @password = password

      @conn = Faraday.new(:url => Zank::BASE_URL) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    # password MD5后登录
    # GET /snowball/api/account/account/login.json
    # device=Android
    # &areaCode=86
    # &device_id=00000000-7daf-05ab-81ec-7d6b3f4adaa4
    # &username=xxx
    # &version=5.2.6
    # &uid=0
    # &zank_channel=selfxf
    # &zank_id=0
    # &authorization=xxx
    # &I18N=CN
    # &captcha= HTTP/1.1
    def login
      response = @conn.get do |req|                         
        req.url LOGIN_PATH, 
                device: 'ios', 
                device_id: UUID.new.generate,
                username: @username,
                version: "5.2.6",
                authorization: Digest::MD5.hexdigest(@password),
                I18N: "CN",
                captcha: "HTTP/1.1"
      end
      result = JSON.parse response.body, symbolize_names: true
      
      self.status = result[:status]
      if result[:status] == 1
        self.user = User.new(result[:data])
        self.token = result[:auth_token]
      else
        self.error = result[:error]
      end
    end

    def logout

    end
  end
end