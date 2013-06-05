class RemoveStatusAndSectorAndUsernameAndNameAndAvatarUrlFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :username
    remove_column :users, :sector
    remove_column :users, :avatar_url
  end

  def down
    add_column :users, :avatar_url, :string
    add_column :users, :username, :string
    add_column :users, :sector
  end
end
