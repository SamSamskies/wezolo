class AddIndexToFollowsTable < ActiveRecord::Migration
  def change
    add_index :follows, [:followable_id, :followable_type, :follower_id], :name => "follow_unique_index"
  end
end
