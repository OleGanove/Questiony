class UsersController < ApplicationController
  before_action :no_access, only: [:show]
  before_action :authenticate_user!

  
  def show
  	@user = User.find(params[:id])
  end

  private

  def no_access
  	@user = User.find(params[:id])
  	unless (current_user == @user) || current_user.friends_with?(@user) 
  	  flash[:alert] = "Tut mir Leid, aber du bist nicht mit der Person befreundet."
  	  redirect_to user_path(current_user)
  	end
  end
end
