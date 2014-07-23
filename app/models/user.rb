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
                    msg = "Today it's going to be #{forecast.weather}"
                    if forecast.precip_prb > 0.5
                        msg = msg + ". It's probably going to rain #{forecast.precip_amt} with probability #{forecast.precip_prb}"
                    else
                        msg = msg + ". It's not going to rain"
                    end
                    msg = msg + ". There's #{forecast.humidity * 100}% humidity. Right now it's #{forecast.temp.round} degrees, and in 5 hours it'll be #{forecast.temp_five.round}"
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
