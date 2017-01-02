class CreateWorkComments < ActiveRecord::Migration[5.0]
  def change
    create_table :work_comments do |t|
      t.string :text
      t.integer :estimation_round_id
      t.string :user_name

      t.timestamps
    end
  end
end
