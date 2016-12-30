class CreateEstimatedWorks < ActiveRecord::Migration[5.0]
  def change
    create_table :estimated_works do |t|
      t.integer :sprint_card_id
      t.integer :user_id
      t.string :user_name
      t.integer :estimated_days

      t.timestamps
    end
  end
end
