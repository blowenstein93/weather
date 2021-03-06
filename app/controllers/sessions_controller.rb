class SessionsController < ApplicationController

 def new
  end

  def create
    user = User.find_by(email: params[:email][:phone].downcase)
    if user && user.authenticate(params[:session][:phone])
        sign_in user
        redirect_to user
    else
        flash[:error] = 'Invalid email/password combination' # Not quite right!
        render 'new'
    end
  end

  def destroy
  end
end
