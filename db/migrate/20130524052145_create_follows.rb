class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :followable_id
      t.string :followable_type
      t.references :follower

      t.timestamps
    end
    add_index :follows, :follower_id
  end
end
