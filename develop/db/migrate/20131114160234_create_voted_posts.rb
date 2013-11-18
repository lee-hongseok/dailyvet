class CreateVotedPosts < ActiveRecord::Migration
  def change
    create_table :voted_posts do |t|
      t.integer :user_id    ,:null =>false
      t.integer :which      ,:null =>false
      t.integer :post_id    ,:null =>false
      t.timestamps
    end
  end
end
