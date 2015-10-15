class FriendshipsController < ApplicationController

  def update
  	@friendship = Friendship.where(friend_id: current_user, user_id: params[:id]).first
  	@friendship.update(approved: true)
  	if @friendship.save
  	  redirect_to :back, :notice => "Freund hinzugefügt."
  	else
  	  redirect_to :back, :notice => "Sorry, Freundschaft konnte nicht bestätigt werden."
  	end
  end

  def destroy
  	# We look for active and passive friendships
    @friendship = Friendship.where(friend_id: [current_user, params[:id]]).where(user_id: [current_user, params[:id]]).last
    @friendship.destroy

    flash[:alert] = "Freundschaft gelöscht."
    redirect_to :back
  end
end
