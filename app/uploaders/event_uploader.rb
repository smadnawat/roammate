class EventUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  version :display do
    process :eager => true
    process :resize_to_fill => [150, 150, :north]
  end

  version :thumbnail do
    process :eager => true
    process :resize_to_fit => [50, 50]
  end


end
