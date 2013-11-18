#encoding:utf-8
class Comment < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :post
  belongs_to :job_post
end
