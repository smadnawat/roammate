class Post < ActiveRecord::Base
  mount_uploader :image, AvatarUploader
  has_many :comments ,dependent: :destroy
  belongs_to :user
end
