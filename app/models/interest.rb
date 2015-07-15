class Interest < ActiveRecord::Base
  mount_uploader :image, AvatarUploader
  mount_uploader :icon, AvatarUploader
  belongs_to :category
  has_many :questions ,dependent: :destroy
  has_many :points, as: :pointable, dependent: :destroy
  has_and_belongs_to_many :users , :join_table => "users_interests" 
end
