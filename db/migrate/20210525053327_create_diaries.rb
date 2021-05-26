class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.string :feeling, null: false
      t.string :body
      t.date :start_time, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :diaries, :start_time, unique: true
  end
end
