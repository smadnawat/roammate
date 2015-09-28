class Album < ActiveRecord::Base
  # mount_uploader :image, AvatarUploader
  belongs_to :user
end
