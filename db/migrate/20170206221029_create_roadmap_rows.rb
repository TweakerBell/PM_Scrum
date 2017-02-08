class CreateRoadmapRows < ActiveRecord::Migration[5.0]
  def change
    create_table :roadmap_rows do |t|
      t.integer :sprint_nr
      t.boolean :is_milestone
      t.string :title
      t.integer :dashboard_id

      t.timestamps
    end
  end
end
