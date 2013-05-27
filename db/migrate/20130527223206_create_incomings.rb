class CreateIncomings < ActiveRecord::Migration
  def change
    create_table :incomings do |t|
      t.references :user
      t.string :message
      t.string :status

      t.timestamps
    end
    add_index :incomings, :user_id
  end
end
