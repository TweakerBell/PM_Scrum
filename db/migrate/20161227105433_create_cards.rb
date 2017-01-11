class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :title
      t.integer :last_board_id
      t.integer :last_user_id
      t.integer :board_id
      t.string :color
      t.integer :sprint_id
      t.integer :position
      t.string :html_id
      t.integer :work_to_do
      t.boolean :is_user_story
      t.string :priority
      t.boolean :done

      t.timestamps
    end
  end
end
