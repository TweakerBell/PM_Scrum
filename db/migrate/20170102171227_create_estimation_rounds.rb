class CreateEstimationRounds < ActiveRecord::Migration[5.0]
  def change
    create_table :estimation_rounds do |t|
      t.integer :sprint_card_id
      t.integer :round_number
      t.boolean :active

      t.timestamps
    end
  end
end
