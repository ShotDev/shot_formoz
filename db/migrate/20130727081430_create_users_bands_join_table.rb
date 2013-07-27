class CreateUsersBandsJoinTable < ActiveRecord::Migration
  def change
    create_table :users_bands, :id => false do |t|
      t.integer :user_id
      t.integer :band_id
    end
  end
end
