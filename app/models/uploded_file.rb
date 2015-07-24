class UplodedFile < ActiveRecord::Base
	mount_uploader :file, FileUploaderUploader
	after_save :file_upload

	def file_upload
	  	if self[:file].present?
	      file_path = "public/uploads/upload_file/file/#{self[:id]}/#{self[:file]}"
	      self.csv_file_method(file_path)
	  	end
	end

	def  csv_file_method(file_path)
	   
	   
 	end




end
