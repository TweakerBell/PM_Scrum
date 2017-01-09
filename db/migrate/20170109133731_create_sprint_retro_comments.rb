class CreateSprintRetroComments < ActiveRecord::Migration[5.0]
  def change
    create_table :sprint_retro_comments do |t|
      t.string :username
      t.string :text
      t.integer :sprint_id
      t.boolean :pro

      t.timestamps
    end
  end
end
