class CreateUsersCountriesTable < ActiveRecord::Migration
  def change
    create_table :countries_users, :id => false do |t|
      t.references :user
      t.references :country
     end
  end
end

