class CreateVotedComments < ActiveRecord::Migration
  def change
    create_table :voted_comments do |t|
      t.integer :user_id    ,:null =>false
      t.integer :which      ,:null =>false
      t.integer :comment_id ,:null =>false
      t.timestamps
    end
  end
end
