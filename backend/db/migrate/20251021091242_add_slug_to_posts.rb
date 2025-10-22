class AddSlugToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :slug, :string
    # For partitioned tables, unique constraints require all partitioning columns
    add_index :posts, [:slug, :user_partition], unique: true
  end
end
