class CreateBlogTypes < ActiveRecord::Migration
  def change
    create_table :blog_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
