class User < ActiveRecord::Base
    has_many :weathers, dependent: :destroy
    validates :email, uniqueness: true
    validates :phone, uniqueness: true
    validates :email, presence: true
    validates :phone, presence: true
    validates :name, presence: true


    def self.daily_text
        @client = Twilio::REST::Client.new("AC35d0abacd00f2ffcc065ca1d53c8b930", "0b1863df59c77930f6d4a12352be5679")

        User.all.each do |user|

            @weathers = Weather.where(user_id: user.id)
            @weathers.each do |forecast|
                if forecast.weekly
                    msg = "Summary: #{forecast.weather}"
                    if forecast.precip_prb > 0.5
                        msg = msg + ". \nIt's probably going to rain #{forecast.precip_amt} with probability #{forecast.precip_prb * 100}%"
                    else
                        msg = msg + ".\n It's not going to rain"
                    end
                    msg = msg + ".\nHumidity: #{forecast.humidity * 100}%. \nCurrent Temp: #{forecast.temp.round} \nTemp in 5 hours: #{forecast.temp_five.round} \n-Your friends at WeatherAlert"
                    begin
                        @client.account.messages.create({
                            :from => 9147757419,
                            :to => user.phone,
                            :body => msg
                        })
                    rescue Twilio::REST::RequestError => e
                        puts e.message
                    end
                end
            end
        end
    end


    def self.weekly_text
        @client = Twilio::REST::Client.new("AC35d0abacd00f2ffcc065ca1d53c8b930", "0b1863df59c77930f6d4a12352be5679")

        User.all.each do |user|
            @weathers = Weather.where(user_id: user.id)
            @weathers.each do |forecast|
                if forecast.weekly
                    msg = "Weekly weather - " + forecast.weekly_summary
                    begin
                        @client.account.messages.create({
                            :from => 9147757419,
                            :to => user.phone,
                            :body => msg
                        })
                    rescue Twilio::REST::RequestError => e
                        puts e.message
                    end
                end
            end
        end
    end

    def self.rain_ntf
        @client = Twilio::REST::Client.new("AC35d0abacd00f2ffcc065ca1d53c8b930", "0b1863df59c77930f6d4a12352be5679")
        User.all.each do |user|
            @weathers = Weather.where(user_id: user.id)
            @weathers.each do |forecast|
                if !forecast.rain_ntf
                    next
                end
                msg = "It's going to rain "
                case
                when forecast.rain_one > 0.5
                    msg = msg + "in the next hour"
                when forecast.rain_four > 0.5
                    msg = msg + "in four hours"
                when forecast.rain_seven > 0.5
                    msg = msg + "in seven hours"
                when forecast.rain_ten > 0.5
                    msg = msg + "in ten hours"
                when forecast.rain_thirt > 0.5
                    msg = msg + "in thirteen hours. I'll remind you again later. "
                end
                msg = msg+"\n-Your friends at WeatherAlert"
                begin
                    @client.account.messages.create({
                        :from => +9147757419,
                        :to => user.phone,
                        :body => msg
                    })
                rescue => e
                    puts e.message
                end
            end
        end
    end

end
