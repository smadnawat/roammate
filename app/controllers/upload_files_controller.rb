class UploadFilesController < ApplicationController
	def upload_file
		@data_import = UplodedFile.new(data_import_params)
		if @data_import.save
		  flash[:notice] = "File uploaded successfully"
		else
		  flash[:error] = "File Upload failed"
		end
		redirect_to admin_upload_file_path
	end

	private

    def data_import_params
      params.require(:upload_csv).permit(:file)
    end
end
