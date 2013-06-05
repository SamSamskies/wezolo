class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body, :null => false
      t.datetime :published_at
      t.references :blog

      t.timestamps
    end
    add_index :posts, :blog_id
  end
end
