require 'net/http'
require 'rubygems'
require 'twilio-ruby'

class Weather < ActiveRecord::Base

validates :address, presence: true
belongs_to :user


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


    def self.text(id)
        client = Twilio::REST::Client.new("AC35d0abacd00f2ffcc065ca1d53c8b930", "0b1863df59c77930f6d4a12352be5679")
        weather = Weather.find(id)
        user = User.find(weather.user_id)
        phone = user.phone.to_i
        begin
            client.account.messages.create({
                :from => +9147757419,
                :to => phone,
                :body => weather.weather
            })
        rescue Twilio::REST::RequestError => e
            return e
        end
        return true
    end
end
