class RemovePreviousMigration < ActiveRecord::Migration
  def up
    change_column :authorizations, :uid, :string, :null => true
  end

  def down
    change_column :authorizations, :uid, :string, :null => false
  end
end
