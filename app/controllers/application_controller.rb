class ApplicationController < ActionController::Base

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
        @user.update_attributes(:online => true,:updated_at => Time.now)
      end
    end
  end
  
  def check_user
  	@user = User.find_by_id(params[:user_id])
  	unless @user and @user.profile.status
  		render :json => {:responseCode => 500,:responseMessage => "User doesn't exist."}
  	end
  end


  # Admin +++++++++++++++++++++++++++++++++++++++++++

  def after_sign_in_path_for(user)
    user.is_admin ? admin_dashboard_path : new_admin_event_path
  end

end
