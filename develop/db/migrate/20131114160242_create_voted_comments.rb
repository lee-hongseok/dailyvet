class CreateVotedComments < ActiveRecord::Migration
  def change
    create_table :voted_comments do |t|
      t.integer :user_id    ,:null =>false
      t.integer :which      ,:null =>false
      t.integer :comment_id ,:null =>false
      t.string  :dummy1
      t.string  :dummy2
      t.string  :dummy3
      t.timestamps
    end
  end
end
