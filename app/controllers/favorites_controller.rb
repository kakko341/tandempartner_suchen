class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    message = Message.find(params[:message_id])
    current_user.favorite(message)
    flash[:success] = 'このメッセージをお気に入りしました。'
    redirect_to message
  end

  def destroy
    message = Message.find(params[:message_id])
    current_user.unfavorite(message)
    flash[:success] = 'このメッセージのお気に入りを解除しました。'
    redirect_to message
  end
end
