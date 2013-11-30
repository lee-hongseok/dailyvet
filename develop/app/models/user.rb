#encoding:utf-8
class User < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :posts
  has_many :comments
  has_many :voted_posts
  has_many :voted_comments
  has_many :job_posts
  def make_token
      hash_src = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
      self.token = Array.new(32){ hash_src.sample }.join
  end
end
