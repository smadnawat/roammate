class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  def check_user
  	@user = User.find_by_id(params[:user_id])
  	unless @user
  		render :json => {:responseCode => 500,:responseMessage => "User doesn't exist."}
  	end
  end

end
