class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :url, :null => false
      t.string :external_id
      t.references :blog_type
      t.references :user

      t.timestamps
    end
  end
end
