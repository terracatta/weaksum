class CreateOsVendors < ActiveRecord::Migration
  def change
    create_table :os_vendors do |t|
      t.string :name

      t.timestamps
    end
  end
end
