class UsersController < ApplicationController
  
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
    @user = User.find(params[:id])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
