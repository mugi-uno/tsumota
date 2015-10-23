class AddNotFoundToItem < ActiveRecord::Migration
  def change
    add_column :items, :not_found, :boolean, default: false
  end
end
