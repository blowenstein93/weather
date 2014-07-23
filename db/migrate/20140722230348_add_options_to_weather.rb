class AddOptionsToWeather < ActiveRecord::Migration
  def change
    add_column :weathers, :daily, :boolean
    add_column :weathers, :weekly, :boolean
    add_column :weathers, :rain, :boolean
    add_column :weathers, :temp_ntf, :boolean
  end
end
