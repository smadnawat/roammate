class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 # protect_from_forgery with: :exception
	# rescue_from ActionController::RoutingError do |exception|
	#   render nothing: true
	# end
before_filter :last_click

rescue_from ActionController::RoutingError do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, notice: "dhjsfgdkjsf" }
      format.json { render :json => {:Response_code => 500,
          :Response_message => "Sorry!Please try again. because #{exception.message}"
          }
       }
    end
end

  def last_click
    if !(params[:controller] == "users" and params[:action] == "login")
      @user = User.find_by_id(params[:user_id])
      if @user.present?
        @user.update_attributes(:online => true,:created_at => Time.now)
      end
    end
  end
  def check_user
  	@user = User.find_by_id(params[:user_id])
  	unless @user
  		render :json => {:responseCode => 500,:responseMessage => "User doesn't exist."}
  	end
  end

end
