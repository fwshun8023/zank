module Zank
  class Client
    attr_accessor :user, :token, :status, :error

    def initialize(username, password)
      @username = username
      @password = password

      @conn = Faraday.new(url: Zank::BASE_URL) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    # password MD5
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
                version: '5.2.6',
                authorization: Digest::MD5.hexdigest(@password),
                I18N: 'CN',
                captcha: 'HTTP/1.1'
      end
      result = JSON.parse response.body, symbolize_names: true

      self.status = result[:status]
      if result[:status] == 1
        self.user = User.new(result[:data])
        self.token = result[:auth_token]
      else
        self.error = result[:error]
      end

      result[:status] == 1
    end

    # /snowball/api/account/account/logout.json
    # ?device=Android
    # &device_id=00000000-7daf-05ab-81ec-7d6b3f4adaa4
    # &token=947dab143272f109d131bb8e588a48e3
    # &version=5.2.6&uid=27149761
    # &zank_channel=selfxf
    # &zank_id=27149761
    # &I18N=CN
    # HTTP/1.1
    def logout
      response = @conn.get do |req|
        req.url LOGOUT_PATH, token: token
      end
      result = JSON.parse response.body, symbolize_names: true

      result[:status] == 1
    end
  end
end
