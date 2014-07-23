class AddRainsToWeathers < ActiveRecord::Migration
  def change
    add_column :weathers, :rain_one, :float
    add_column :weathers, :rain_four, :float
    add_column :weathers, :rain_seven, :float
    add_column :weathers, :rain_ten, :float
    add_column :weathers, :rain_thirt, :float
  end
end
