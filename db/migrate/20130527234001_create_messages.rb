class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :message
      t.references :user
      t.string :msg_type
      t.string :status
      t.references :parent

      t.timestamps
    end
    add_index :messages, :user_id
    add_index :messages, :parent_id
  end
end
