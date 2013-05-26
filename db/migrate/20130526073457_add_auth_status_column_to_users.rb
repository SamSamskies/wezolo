class AddAuthStatusColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_status, :string, :default => "incomplete"
  end
end
