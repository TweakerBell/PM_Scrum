class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :title
      t.integer :last_board_id
      t.integer :last_user_id
      t.integer :board_id

      t.timestamps
    end
  end
end
