class Weather < ActiveRecord::Base

validates :address, presence: true


    def self.geocode(address)
        address = address.gsub(" ", "+")
        key = "AIzaSyANsWZLOyo2JZHehEd2cZuSBo9CBikIVkU"
        url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=#{key}"
        response = Net::HTTP.get_response(URI.parse(url))
        response.body
    end

    def self.forecast(lat, lng)
        key = "c7029536b8ada6489900b7348dea7c2d"
        url = "https://api.forecast.io/forecast/#{key}/#{lat},#{lng}"
        response = Net::HTTP.get_response(URI.parse(url))
        response.body
    end


end
