class ChangeUsersCountriestoInvolements < ActiveRecord::Migration
  def change 
    rename_table :countries_users, :involvements
  end
end
