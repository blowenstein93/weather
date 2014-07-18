class CreateWeathers < ActiveRecord::Migration
  def change
    create_table :weathers do |t|
      t.string :weather
      t.string :address
      t.float :lat
      t.float :lng
      t.float :temp
      t.float :precip_amt
      t.float :precip_prb
      t.float :humidity
      t.float :wind_speed
      t.float :temp_one
      t.float :temp_two
      t.float :temp_three
      t.float :temp_four
      t.float :temp_five
      t.string :weekly_summary

      t.timestamps
    end
  end
end
