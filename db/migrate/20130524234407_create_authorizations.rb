class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :uid
      t.references :user
      t.references :auth_provider

      t.timestamps
    end
    add_index :authorizations, :user_id
    add_index :authorizations, :auth_provider_id
  end
end
