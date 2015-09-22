class Event < ActiveRecord::Base
	mount_uploader :image, AvatarUploader
	has_many :likes , dependent: :destroy
end
