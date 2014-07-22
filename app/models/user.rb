class User < ActiveRecord::Base
    has_many :weathers, dependent: :destroy
    validates :email, uniqueness: true
    validates :phone, uniqueness: true
    validates :email, presence: true
    validates :phone, presence: true
    validates :name, uniqueness: true


    def text
        @client = Twilio::REST::Client.new("AC35d0abacd00f2ffcc065ca1d53c8b930", "0b1863df59c77930f6d4a12352be5679")

        User.all.each do |user|

            @weathers = Weather.where(user_id: user.id)
            @weathers.each do |forecast|
                client.accountmessages.create({
                    :from => 9147757419,
                    :to => user.phone,
                    :body => forecast.weather
                })
            end
        end
    end

end
