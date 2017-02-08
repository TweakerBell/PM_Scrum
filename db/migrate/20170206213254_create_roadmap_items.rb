class CreateRoadmapItems < ActiveRecord::Migration[5.0]
  def change
    create_table :roadmap_items do |t|
      t.boolean :is_user_story
      t.boolean :is_feature
      t.integer :roadmap_row_id
      t.string :title

      t.timestamps
    end
  end
end
