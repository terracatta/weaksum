class CreateOperatingSystems < ActiveRecord::Migration
  def change
    create_table :operating_systems do |t|
      t.string :name
      t.integer :os_vendor_id

      t.timestamps
    end
  end
end
