class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

    
  def index
    if logged_in?
      @user = current_user
      @message = current_user.messages.build
      @messages = current_user.feed_messages.order(id: :desc).page(params[:page])
    else
      @messages = Message.order(id: :desc).page(params[:page])
    end
  end

  def show
  end

  def new
    @message = Message.new
  end

  def create
    @message = current_user.messages.build(message_params)
    
    if @message.save
      flash[:success] = "Succeeded the post!"
      redirect_to root_url
    else
      flash.now[:danger] = "Failed to create a post"
      render :new
    end
  end

  def edit
  end

  def update
    
    if @message.update(message_params)
      flash[:success] = "Updated the post!"
      redirect_to root_url
    else
      @feed_items = []
      flash.now[:danger] = "Failed to update the post"
      render :edit
    end
  end

  def destroy
    @message.destroy
    flash[:success] = "Deleted the post."
    redirect_to messages_url
  end
  
  private
  
  def set_message
    @message = Message.find(params[:id])
  end
  
  #strong parameter
  def message_params
    params.require(:message).permit(:content, :title, images: [])
  end
  
end
