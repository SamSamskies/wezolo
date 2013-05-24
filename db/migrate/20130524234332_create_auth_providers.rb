class CreateAuthProviders < ActiveRecord::Migration
  def change
    create_table :auth_providers do |t|
      t.string :name

      t.timestamps
    end
  end
end
