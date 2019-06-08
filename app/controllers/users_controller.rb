class UsersController < ApplicationController
  
  def show
    @page_title = @user.name
    @user = User.find(params[:id])
  end
  
  def new
    @page_title = 'signup'
    @user = User.new
  end
  
  def create
    @page_title = 'signup'
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
