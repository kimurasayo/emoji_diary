class AddScoreToDiaries < ActiveRecord::Migration[6.1]
  def change
    add_column :diaries, :score, :integer
  end
end
