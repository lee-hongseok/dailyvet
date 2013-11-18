#encoding: utf-8
class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id , :null =>false
      t.integer :job_post_id 
      t.integer :post_id  
      t.boolean :anomynous_flag, :default => false
      t.boolean :delete_flag, :default =>false
      t.string  :content, :null =>false
      t.integer :vote_up,    :default => 0
      t.integer :vote_down,    :default => 0

      t.timestamps
    end
  end
end
