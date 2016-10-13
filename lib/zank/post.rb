module Zank
  class Post
    attr_accessor :id, :user_id, :city, :icon, :title, :content, :created_at, :comment_count, :cover_url, :img_small, :img_big, :timestamp

    def initialize(opts)
      self.id            = opts[:postId]
      self.user_id       = opts[:uid]
      self.city          = opts[:city]
      self.icon          = opts[:icon]
      self.title         = opts[:title]
      self.content       = opts[:content]
      self.created_at    = Time.at(opts[:timestamp].to_i / 1000) if opts[:timestamp]
      self.timestamp     = opts[:timestamp]
      self.comment_count = opts[:commentCount]
      self.cover_url     = opts[:coverUrl]
      self.img_small     = opts[:img_small].join(',')
      self.img_big       = opts[:img_big].join(',')
    end
  end
end
