class CreateDashboards < ActiveRecord::Migration[5.0]
  def change
    create_table :dashboards do |t|
      t.integer :project_id
      t.timestamps
    end
  end
end
