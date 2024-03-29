class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    message = Message.find(params[:message_id])
    current_user.favorite(message)
    flash[:success] = 'Added to Likelist'
    redirect_to root_url
  end

  def destroy
    message = Message.find(params[:message_id])
    current_user.unfavorite(message)
    flash[:danger] = 'Removed from Likelist'
    redirect_back(fallback_location: root_url)
  end
end
