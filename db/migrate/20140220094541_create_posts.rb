class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.text :thumbnail
      t.integer :created_by
      t.integer :updated_by
      t.integer :lock_version, :default=>0, :null=>false

      t.timestamps
    end
  end
end
