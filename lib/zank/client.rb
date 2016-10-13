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
        username: @username,
        version: '5.2.6',
        authorization: Digest::MD5.hexdigest(@password)
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
      result = response(LOGOUT_PATH, :get, token: token)
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
      data = auth_response(CIRCLES_PATH, :get, token: token, page: opts[:page], pageSize: 20)
      data[:circle].collect do |circle|
        Circle.new(circle)
      end
    end

    # /snowball/api/circle/circle/getCircle.json?device=Android
    # &device_id=00000000-7daf-05ab-81ec-7d6b3f4adaa4&token=9abb708c56c08a61825d597053aba443
    # &circleId=135&version=5.2.6&pageSize=20&zank_channel=selfxf&uid=27149761&zank_id=27149761&I18N=CN HTTP/1.1
    def posts(opts = {})
      raise 'must have circle_id' if opts[:circle_id].nil?

      timestamp = opts[:timestamp] || (Time.now.to_f * 1000).to_i
      data = auth_response(POSTS_PATH, :get,
        circleId: opts[:circle_id],
        token: token,
        timestamp: timestamp
      )
      
      data[:post].collect do |post|
        Post.new(post)
      end
    end

    def user_detail(uid)
      data = auth_response(USER_PATH, :get, uid: uid, token: token)
      User.new(data)
    end

    private

    def response(path, request_method = :get, params = {}, &block)
      if block
        result = yield(@conn)
      else
        result = @conn.send(request_method) { |req| req.url path, params.merge(default_params) }
      end

      JSON.parse(result.body, symbolize_names: true)
    end

    def auth_response(path, request_method = :get, params = {}, &block)
      raise('must login') unless status == 1

      result = response(path, request_method, params, &block)

      raise(result.to_s) unless result[:status] == 1

      result[:data]
    end

    def default_params
      {
        device: 'ios',
        # device_id: UUID.new.generate,
        device_id: '00000001-7dsf-05rb-81ec-7d6b3f4agaa4',
        version: '5.2.6',
        I18N: 'CN'
      }
    end
  end
end
