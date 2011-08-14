class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :md5
      t.string :sha1
      t.string :sha256
      t.string :fuzzy_hash
      t.text :description
      t.string :upload_file_name
      t.string :upload_content_type
      t.integer :upload_file_size
      t.datetime :upload_updated_at

      t.timestamps
    end
  end
end
