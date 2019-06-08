class SessionsController < ApplicationController
  def new
    @page_title = 'Log in'
  end
  
  def create
    @page_title = ''
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
    else
      flash.now[:danger] = 'invalid email/password combination'
      render 'new'
    end
  end
end
