class AddPhotoUrlToBands < ActiveRecord::Migration
  def change
    add_column :bands, :photo_url, :string
  end
end
