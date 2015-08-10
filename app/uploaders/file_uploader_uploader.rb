# encoding: utf-8
class FileUploaderUploader < CarrierWave::Uploader::Base
 
  storage :file
 
  def extension_white_list
    %w(csv)
  end
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
