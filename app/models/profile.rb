class Profile < ActiveRecord::Base
 # mount_uploader :image, AvatarUploader
  belongs_to :user
  has_many :points, as: :pointable, dependent: :destroy
end
