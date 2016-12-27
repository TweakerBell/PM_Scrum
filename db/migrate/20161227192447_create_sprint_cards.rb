class CreateSprintCards < ActiveRecord::Migration[5.0]
  def change
    create_table :sprint_cards do |t|
      t.string :title
      t.integer :last_sprint_board_id
      t.integer :last_user_id
      t.integer :user_id
      t.integer :priority
      t.integer :position
      t.integer :sprint_board_id
      t.boolean :visible
      t.string :change_request

      t.timestamps
    end
  end
end
