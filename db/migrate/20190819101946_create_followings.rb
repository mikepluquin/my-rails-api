class CreateFollowings < ActiveRecord::Migration[5.2]
  def change
    create_table :followings do |t|
      t.integer 'followed_id'
      t.integer 'follower_id'

      t.timestamps
    end
    add_index :followings, :followed_id
    add_index :followings, :follower_id
  end
end
