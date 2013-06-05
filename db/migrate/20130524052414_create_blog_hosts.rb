class CreateBlogHosts < ActiveRecord::Migration
  def change
    create_table :blog_hosts do |t|
      t.string :name

      t.timestamps
    end
  end
end
