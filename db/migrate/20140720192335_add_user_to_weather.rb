class AddUserToWeather < ActiveRecord::Migration
  def change
    add_reference :weathers, :user
  end
end
