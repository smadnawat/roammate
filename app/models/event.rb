class Event < ActiveRecord::Base
	mount_uploader :image, EventUploader
	has_many :likes , dependent: :destroy
	belongs_to :interest
	validates_presence_of  :image

	def self.like_on_event event, user
		count = event.likes.where(status: true).count
		like = Like.where(event_id: event.id, user_id: user.id).first
		if like
			like.update_attributes(status: !like.status)
			like.status ? count += 1 : count -= 1
		else
			event.likes.create(status: true, user_id: user.id)
			count += 1
		end
		count
	end
end
