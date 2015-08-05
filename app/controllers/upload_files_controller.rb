class UploadFilesController < ApplicationController
	def upload_file
		@file = Profile.import(params[:upload_csv][:file])
		if @file == "y"		
		  flash[:notice] = "File uploaded successfully"
		else
		  flash[:error] = @file
		end
		redirect_to admin_upload_file_path
	end
end
