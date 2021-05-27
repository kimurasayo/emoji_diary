class DeleteStartTimeUniqIndexFromDiaries < ActiveRecord::Migration[6.1]
  def change
    remove_index :diaries, :start_time
  end
end
