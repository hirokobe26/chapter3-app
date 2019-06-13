class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @page_title = @user.name
  end
  
  def new
    @page_title = 'signup'
    @user = User.new
  end
  
  def create
    @page_title = 'signup'
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @page_title = 'Edit user'
    @user = User.find(params[:id])
  end
  
  def update
    @page_title = 'update'
    @user = User.find(params[:id]) #失敗した時にNilを返すのでここでチェックして、If分にはいる
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
