class CreateJobPosts < ActiveRecord::Migration
  def change
    create_table :job_posts do |t|

      t.integer    :user_id  ,         :null => false
      t.string     :each     ,         :null => false
      t.string     :hour     ,         :null => false
      t.string     :name     ,         :null => false
      t.string     :address_detail,    :null => false
      t.string     :to       ,         :null => false
      t.string     :pay      ,         :null => false
      t.string     :qualification ,    :null => false
      t.string     :experience    ,    :null => false
      t.string     :favorite      ,    :null => false
      t.string     :tel           ,    :null => false
      t.string     :hp            ,    :null => false
      t.string     :method        ,    :null => false
      t.string     :dead_line     ,    :null => false
      t.string     :detail        ,    :null => false
      t.string     :title  ,           :null => false
      t.integer    :counter,           :default => 0
      t.boolean    :notice_flag,       :default => false
      t.boolean    :delete_flag ,      :default => false
      t.string     :category  ,        :null => false
      t.string     :city,              :null => false
      t.string     :county ,           :null => false
      t.string     :dummy1
      t.string     :dummy2
      t.string     :dummy3
      t.string     :dummy4 
      t.string     :dummy5 
      t.string     :dummy6 
      t.string     :dummy7 
      t.string     :dummy8
      t.timestamps
    end
  end
end
