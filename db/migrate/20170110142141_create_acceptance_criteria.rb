class CreateAcceptanceCriteria < ActiveRecord::Migration[5.0]
  def change
    create_table :acceptance_criteria do |t|
      t.integer :card_id
      t.string :text

      t.timestamps
    end
  end
end
