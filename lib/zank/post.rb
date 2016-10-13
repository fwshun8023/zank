module Zank
  class Post
    attr_accessor :id, :uid, :username, :city, :icon, :title, :content, :created_at, :comment_count, :cover_url, :img_small, :img_big, :timestamp

    def initialize(opts)
      self.id            = opts[:postId]
      self.uid           = opts[:uid]
      self.username      = opts[:username]
      self.city          = opts[:city]
      self.icon          = opts[:icon]
      self.title         = opts[:title]
      self.content       = opts[:content]
      self.created_at    = Time.at(opts[:timestamp].to_i / 1000) if opts[:timestamp]
      self.timestamp     = opts[:timestamp]
      self.comment_count = opts[:commentCount]
      self.cover_url     = opts[:coverUrl]
      self.img_small     = opts[:img_small]
      self.img_big       = opts[:img_big]
    end
  end
end
