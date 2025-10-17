class AddStatusToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :status, :string, null: false, default: 'draft'
    add_index :posts, :status
  end
end
