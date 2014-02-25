class AddTitleImgToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :preview_img, :text
  end
end
