class Event < ActiveRecord::Base
	mount_uploader :image, EventUploader
	has_many :likes , dependent: :destroy
	belongs_to :interest
end
