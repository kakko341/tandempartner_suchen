class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followers, :followings, :likes,
                                                :edit, :update, :destroy]
  
  def index
    @users = User.all.page(params[:page]).search(params[:search])
  end

  def show
    @user = User.find(params[:id])
    @messages = @user.messages.order('created_at DESC').page(params[:page])
    counts(@user)
    @room_id = talk_room_id(current_user, @user)
    @talks = Talk.recent_in_room(@room_id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "Account created"
      redirect_to @user
    else
      flash.now[:danger] = "Failed to create an account"
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      flash[:now] = "It's failed to update"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Account deleted"
    redirect_to users_url
  end
  
  def comments
    @user = User.find(params[:id])
    @comments = @user.messages.page(params[:page])
    counts(@messages)
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @favmessages = @user.favmessages.order('created_at DESC').page(params[:page])
    counts(@user)
  end
  
  def talk_room_id(first_user, second_user)
    first_id = first_user.id.to_i
    second_id = second_user.id.to_i
      if first_id < second_id
        "#{first_user.id}-#{second_user.id}"
      else
        "#{second_user.id}-#{first_user.id}"
      end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                  :speak, :offer, :place, :age)
  end
  
  def comment_params
    params.require(:comment).permit(:content)
  end
end
