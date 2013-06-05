class ChangeColumnsInAuthorizations < ActiveRecord::Migration
  def up
    change_column :authorizations, :uid, :string, :null => false
    change_column :authorizations, :auth_provider_id, :integer, :null => false
  end

  def down
    change_column :authorizations, :uid, :string
    change_column :authorizations, :auth_provider_id, :integer
  end
end
