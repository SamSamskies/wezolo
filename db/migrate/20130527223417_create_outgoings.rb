class CreateOutgoings < ActiveRecord::Migration
  def change
    create_table :outgoings do |t|
      t.references :user
      t.string :message
      t.references :incoming

      t.timestamps
    end
    add_index :outgoings, :user_id
    add_index :outgoings, :incoming_id
  end
end
