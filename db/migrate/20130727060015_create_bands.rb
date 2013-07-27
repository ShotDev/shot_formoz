class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.string :stage

      t.timestamps
    end
  end
end
