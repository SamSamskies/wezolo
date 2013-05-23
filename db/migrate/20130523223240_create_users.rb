class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :status
      t.string :email 
      t.string :sector
      t.string :username
      t.string :name
      t.string :avatar_url
      t.string :password_digest

      t.references :country
      
      t.timestamps
    end
  end
end
