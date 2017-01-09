class CreateChangeRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :change_requests do |t|
      t.integer :sprint_card_id
      t.string :text
      t.string :username
      t.timestamps
    end
  end
end
