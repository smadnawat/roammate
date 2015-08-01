class Interest < ActiveRecord::Base
  mount_uploader :image, AvatarUploader
  mount_uploader :icon, AvatarUploader
  mount_uploader :banner, AvatarUploader
  belongs_to :category
  has_many :questions ,dependent: :destroy
  has_many :special_messages ,dependent: :destroy
  has_and_belongs_to_many :users , :join_table => "users_interests" 
end
