class AddAccessAndRecommendToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :access, :integer, :default => 0, :null => false
    add_column :posts, :recommend, :integer, :default => 0, :null => false
  end
end
