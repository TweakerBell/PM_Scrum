class CreateStatistics < ActiveRecord::Migration[5.0]
  def change
    create_table :statistics do |t|
      t.integer :work_total
      t.integer :work_done
      t.integer :work_left
      t.integer :sprint_id

      t.timestamps
    end
  end
end
