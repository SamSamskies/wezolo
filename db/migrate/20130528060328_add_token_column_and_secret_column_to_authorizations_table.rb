class AddTokenColumnAndSecretColumnToAuthorizationsTable < ActiveRecord::Migration
  def change
    add_column :authorizations, :token, :string
    add_column :authorizations, :secret, :string
    change_column :authorizations, :uid, :string
  end
end
