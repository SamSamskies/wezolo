class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :body, :null => false
      t.datetime :published_at
      t.references :blog

      t.timestamps
    end
    add_index :blog_posts, :blog_id
  end
end
