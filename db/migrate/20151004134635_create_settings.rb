class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.text :root_path

      t.timestamps null: false
    end
  end
end
