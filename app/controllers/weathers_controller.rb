
class WeathersController < ApplicationController
    def new
        @weather = Weather.new
    end

    def create
        @weather = Weather.new(weather_params)
        if @weather.save
            json = Weather.geocode(@weather.address)
            json = JSON.parse(json)
            @weather.lat = json["results"][0]["geometry"]["location"]["lat"]
            @weather.lng = json["results"][0]["geometry"]["location"]["lng"]
            json = Weather.forecast(@weather.lat, @weather.lng)
            json = JSON.parse(json)
            @weather.weather = json["currently"]["summary"]
            @weather.temp = json["currently"]["apparentTemperature"]
            @weather.precip_prb = json["currently"]["precipProbability"]
            @weather.precip_amt = json["currently"]["precipIntensity"]
            @weather.humidity = json["currently"]["humidity"]
            @weather.wind_speed = json["currently"]["windSpeed"]
            @weather.temp_one = json["hourly"]["data"][0]["apparentTemperature"]
            @weather.temp_two = json["hourly"]["data"][1]["apparentTemperature"]
            @weather.temp_three = json["hourly"]["data"][2]["apparentTemperature"]
            @weather.temp_four = json["hourly"]["data"][3]["apparentTemperature"]
            @weather.temp_five = json["hourly"]["data"][4]["apparentTemperature"]
            @weather.weekly_summary = json["daily"]["summary"]

            @weather.rain_one = json["hourly"]["data"][0]["precipProbability"]
            @weather.rain_four = json["hourly"]["data"][3]["precipProbability"]
            @weather.rain_seven = json["hourly"]["data"][6]["precipProbability"]
            @weather.rain_ten = json["hourly"]["data"][9]["precipProbability"]
            @weather.rain_thirt = json["hourly"]["data"][12]["precipProbability"]

            @weather.save
            redirect_to(weather_path(@weather.id))
        else
            render 'new'
        end
    end

    def show
        @weather = Weather.find(params[:id])
    end

    def index
        @weathers = Weather.all
    end

    def destroy
        weather = Weather.find(params[:id])
        weather.destroy
        redirect_to :back
    end


    def text
        if Weather.text(params[:id])
            redirect_to :back
        else
            redirect_to root_path
        end
    end

    private

    def weather_params
        params.require(:weather).permit(:lat, :lng, :weather, :address, :temp, :precip_prob, :precip_amt, :humidity, :wind_speed, :temp_one, :temp_two, :temp_three, :temp_four, :temp_five, :weekly_summary, :user_id, :daily, :weekly, :rain, :temp_ntf, :rain_one, :rain_four, :rain_seven, :rain_ten, :rain_thirt)
    end
end
