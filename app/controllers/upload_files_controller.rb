class UploadFilesController < ApplicationController
	def upload_file
		if Profile.import(params[:upload_csv][:file])		
		  flash[:notice] = "File uploaded successfully"
		else
		  flash[:error] = "File Upload failed ! upload a valid csv file"
		end
		redirect_to admin_upload_file_path
	end
end
