module Zank
  class User
    # "uid"=>"27149761",
    # "username"=>"fwshun",
    # "avatar"=>"http://pic.zank.mobi/avatar/5/e/5ea5d0a7ec9c203b3df3dc6e0054b603.jpg@!webps",
    # "vip"=>"0",
    # "follownum"=>"13",
    # "fansnum"=>"3",
    # "visitnum"=>"249",
    # "province"=>"上海",
    # "city"=>"普陀",
    # "email"=>"",
    # "phone"=>"185****7845",
    # "age"=>26,
    # "height"=>"172",
    # "weight"=>"70",
    # "regtime"=>"1451111480",
    # "sex_type"=>"1",
    # "message_avatar"=>"http://pic.zank.mobi/avatar/5/e/5ea5d0a7ec9c203b3df3dc6e0054b603.jpg"
    attr_accessor :uid, :username, :avatar, :vip, :follownum, :visitnum, :province, :city, :email, :phone, :age, :height, :weight, :regtime, :sex_type, :message_avatar

    def initialize(opts)
      self.uid            = opts[:uid]
      self.username       = opts[:username]
      self.avatar         = opts[:avatar]
      self.follownum      = opts[:follownum]
      self.province       = opts[:province]
      self.email          = opts[:email]
      self.phone          = opts[:phone]
      self.age            = opts[:age]
      self.height         = opts[:height]
      self.weight         = opts[:weight]
      self.regtime        = opts[:regtime]
      self.sex_type       = opts[:sex_type]
      self.message_avatar = opts[:message_avatar]
    end
  end
end