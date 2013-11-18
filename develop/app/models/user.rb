#encoding:utf-8
class User < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :posts
  has_many :comments
  has_many :voted_posts
  has_many :voted_comments
  has_many :job_posts

end
