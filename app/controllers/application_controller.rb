class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	
	include SessionsHelper
	
	def after_sign_in_path_for(_resource)
    user_path(current_user)
	end

  def after_sign_up_path_for(_resource)
    user_path(current_user)
  end
	
	private
	
		def require_user_logged_in
			unless logged_in?
				flash[:danger] = 'Please log in'
				redirect_to login_url
			end
		end
		
		def counts(user)
	    @count_messages = user.messages.count
	    @count_followings = user.followings.count
	    @count_followers = user.followers.count
			@count_favorites = user.favmessages.count
		end
	
	protected

	  def configure_permitted_parameters
	    added_attrs = %i[name email password password_confirmation image image_cache remove_image　]
	    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
	    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
	    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
	  end
end
