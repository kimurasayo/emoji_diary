class CreateLineUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :line_users do |t|
      t.string :uid

      t.timestamps
    end
  end
end
