class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 # protect_from_forgery with: :exception
	# rescue_from ActionController::RoutingError do |exception|
	#   render nothing: true
	# end


rescue_from ActionController::RoutingError do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, notice: "dhjsfgdkjsf" }
      format.json { render :json => {:Response_code => 500,
          :Response_message => " Sorry!Please try again. because #{exception.message}"
                                    }
                  }
    end
  end

end
