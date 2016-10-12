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
      params = {
        device: 'ios',
        device_id: UUID.new.generate,
        username: @username,
        version: '5.2.6',
        authorization: Digest::MD5.hexdigest(@password),
        I18N: 'CN',
        captcha: 'HTTP/1.1'
      }
      result = response(LOGIN_PATH, :get, params)

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
      result = response(LOGOUT_PATH, :get, { token: token })
      success = result[:status] == 1
      self.status = 0 if success
      success
    end


    # /snowball/api/circle/circle/queryMyCircle.json?device=Android
    # &device_id=00000000-7daf-05ab-81ec-7d6b3f4adaa4&token=524c60d198f69a395e823601c7b51fc3&version=5.2.6
    # &zank_channel=selfxf&uid=27149761&zank_id=27149761&page=1&I18N=CN HTTP/1.1
    # params opts = {}
    # opts[:page]
    # opts[:page_size] => pageSize
    def circles(opts = {})
      data = auth_response(CIRCLES_PATH, :get, { token: token, page: opts[:page], pageSize: opts[:page_size] })
      data[:circle].collect do |circle|
        Circle.new(circle)
      end
    end

    private
      def response(path, method = :get, params = {}, &block)
        if block
          result = yield(@conn)
        else
          result = @conn.send(method){|req| req.url path, params }
        end

        JSON.parse(result.body, symbolize_names: true)
      end

      def auth_response(path, method = :get, params = {}, &block)
        raise("must login") unless self.status == 1
        result = response(path, method = :get, params, &block)

        raise(result.to_s) unless result[:status] == 1
        result[:data]
      end


  end
end
