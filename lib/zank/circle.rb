module Zank
  class Circle
    # {:takeCount=>"868", :commentRole=>"1", :timestamp=>1473847270358, :notice=>"5",
    # :postRole=>"2", :updateTime=>"1473847270358", :commentCount=>"1765",
    # :coverUrl=>"http://photo.zank.mobi/circle/2/1/2119a55bad57a9afdcc4606fa4112cf3.jpg@!webps",
    # :circleId=>"135", :descript=>"xxx", :circleName=>"yyy"}

    attr_accessor :id, :descript, :name, :take_count, :comment_role, :created_at, :notice, :post_role, :updated_at, :comment_count, :cover_url

    def initialize(opts)
      self.id            = opts[:circleId]
      self.name          = opts[:circleName]
      self.descript      = opts[:descript]
      self.take_count    = opts[:takeCount]
      self.comment_role  = opts[:commentRole]
      self.created_at    = Time.at(opts[:timestamp].to_i / 1000) if opts[:timestamp]
      self.notice        = opts[:notice]
      self.post_role     = opts[:postRole]
      self.updated_at    = Time.at(opts[:updateTime].to_i / 1000) if opts[:updateTime]
      self.comment_count = opts[:commentCount]
      self.cover_url     = opts[:coverUrl]
    end
  
  end
end