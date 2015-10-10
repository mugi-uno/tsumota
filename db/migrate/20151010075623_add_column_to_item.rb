class AddColumnToItem < ActiveRecord::Migration
  def change
    add_column :items, :download_count, :integer, :default => 0
  end
end
