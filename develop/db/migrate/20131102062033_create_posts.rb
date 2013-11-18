#encoding: utf-8
class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer    :user_id  ,         :null => false
      t.string     :title  ,           :null => false
      t.boolean    :anomynous_flag,    :default => false
      t.boolean    :notice_flag,       :default => false
      t.boolean    :delete_flag ,      :default => false
      t.string     :content  ,         :null => false
      t.integer    :category  ,        :null => false
                    #1 : 분류1
                    #2 : 분류2
                    #3 : 분류3
                    #4 : 분류4
                    #5 : 분류5
                    #-1 : 구인게시판
                    #-2 : 구인게시판
      t.integer    :job_area
      t.integer    :vote_up,           :default => 0
      t.integer    :vote_down,         :default => 0
      t.integer    :counter,           :default => 0
      t.timestamps
    end
  end
end
