class UsersController < ApplicationController
  
  def show
    @page_title = ""
    @user = User.find(params[:id])
  end
  
  def new
    @page_title = 'signup'
  end
end
