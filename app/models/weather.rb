require 'net/http'
require 'rubygems'
require 'twilio-ruby'

class Weather < ActiveRecord::Base

validates :address, presence: true
belongs_to :user

    def self.text_helper
        Weather.all.each do |weather|
            Weather.text(weather.id)
        end
    end


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
        account_sid = "AC35d0abacd00f2ffcc065ca1d53c8b930"
        auth = "0b1863df59c77930f6d4a12352be5679"
        weather = Weather.find(id)
        user = User.find(weather.user_id)
        phone = user.phone.to_i
        begin
            client = Twilio::REST::Client.new(account_sid, auth)
            response = client.account.messages.create( {
                :body => "The weather outside is " + weather.weather + ". This was a test message sent from WeatherAlert. Add me to your contacts!",
                :to => phone,
                :from => "+19147757419",
            })

            puts response.body
        rescue Twilio::REST::RequestError => e
            puts e.message
            return false
        end
        return true
    end
end
