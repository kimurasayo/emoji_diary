class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :user
      t.references :follower, foreign_key: { to_table: :users }

      t.timestamps

      t.index [:user_id, :follower_id], unique: true
    end
  end
end
