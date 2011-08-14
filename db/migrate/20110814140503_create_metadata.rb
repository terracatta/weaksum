class CreateMetadata < ActiveRecord::Migration
  def change
    create_table :metadata do |t|
      t.string :name
      t.text :value
      t.integer :item_id

      t.timestamps
    end
  end
end
