class CreateSprints < ActiveRecord::Migration[5.0]
  def change
    create_table :sprints do |t|

      t.integer :dashboard_id
      t.integer :sprint_number
      t.boolean :active
      t.boolean :started
      t.boolean :finished
      t.timestamps
    end
  end
end
