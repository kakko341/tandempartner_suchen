class TopPagesController < ApplicationController
  
  def home
    if logged_in?
      @user = current_user
      @message = current_user.messages.build
      @messages = current_user.feed_messages.order('created_at DESC').page(params[:page])
    end
  end
end
