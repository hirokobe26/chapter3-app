class SessionsController < ApplicationController
  def new
    @page_title = 'Log in'
  end
  
  def create
    @page_title = ''
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) #入力された値とDB内のハッシュ化されたパスワードを付け合わせる
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = 'invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
