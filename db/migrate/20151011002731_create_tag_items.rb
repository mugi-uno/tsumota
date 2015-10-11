class CreateTagItems < ActiveRecord::Migration
  def change
    create_table :tag_items do |t|
      t.integer :tag_id
      t.integer :item_id

      t.timestamps null: false
    end
  end
end
