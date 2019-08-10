class TopPagesController < ApplicationController
  
  def home
    if logged_in?
      @user = current_user
      @message  = current_user.messages.build
      @feed_items = current_user.feed_messages.order('created_at DESC').page(params[:page]).search(params[:search])
    else
      @user = User.new
    end
  end
end
