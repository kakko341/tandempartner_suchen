class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
<<<<<<< HEAD
      flash[:success] = 'Succeeded to log in'
=======
      flash[:success] = 'Suceeded lon in'
>>>>>>> 72aa981102d525f0f93f0c887601db612ffc8fc3
      redirect_to root_url
    else
      flash.now[:danger] = 'Failed to log in'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
<<<<<<< HEAD
    flash[:success] = "Logged out"
=======
    flash[:success] = "Log out"
>>>>>>> 72aa981102d525f0f93f0c887601db612ffc8fc3
    redirect_to root_url
  end
  
  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end

end
