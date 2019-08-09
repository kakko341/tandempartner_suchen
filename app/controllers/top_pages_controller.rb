class TopPagesController < ApplicationController
  
  def home
    if logged_in?
      @user = current_user
<<<<<<< HEAD
      @message  = current_user.messages.build
      @feed_items = current_user.feed_messages.order('created_at DESC').page(params[:page]).search(params[:search])
    else
      @user = User.new
=======
      @message = current_user.messages.build
      @messages = current_user.feed_messages.order('created_at DESC').page(params[:page])
>>>>>>> 72aa981102d525f0f93f0c887601db612ffc8fc3
    end
  end
end
