class CreateSprintBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :sprint_boards do |t|
      t.string :title
      t.integer :sprint_id

      t.timestamps
    end
  end
end
