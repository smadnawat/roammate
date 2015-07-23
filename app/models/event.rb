class Event < ActiveRecord::Base
	mount_uploader :image, AvatarUploader
end
