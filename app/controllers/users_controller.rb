class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
        redirect_to (user_path(@user.id))
    else
        render 'new'
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @weathers = Weather.where(user_id: params[:id])
  end

  def edit
    @user = User.new()
  end


  def destroy
    @user= User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  def signin
  end

  def search
    user = User.where(email: params[:email]).first
    if user.nil?
      redirect_to root_path
    end
    redirect_to user_path(user.id)
  end

  def error
    redirect_to "/error"
  end

  def daily_text
    User.daily_text
  end

  def weekly_text
    User.weekly_text
  end

  def rain_ntf
    User.rain_ntf
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :weathers)
  end

end
