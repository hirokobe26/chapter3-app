class AccountActivationsController < ApplicationController
    def edit
        @user = User.find_by(email: params[:email])
        if @user.authenticated?(params[:id])
        else
        end
    end
end
