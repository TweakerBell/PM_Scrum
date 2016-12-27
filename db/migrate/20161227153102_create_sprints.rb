class CreateSprints < ActiveRecord::Migration[5.0]
  def change
    create_table :sprints do |t|

      t.integer :dashboard_id
      t.timestamps
    end
  end
end
