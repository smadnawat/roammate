class Interest < ActiveRecord::Base
  mount_uploader :image, AvatarUploader
  mount_uploader :icon, AvatarUploader
  mount_uploader :banner, AvatarUploader
  belongs_to :category
  has_many :questions ,dependent: :destroy
  has_many :special_messages ,dependent: :destroy
  has_and_belongs_to_many :users , :join_table => "users_interests" 


  def self.view_matches_algo selected_interest
  	matches = []
  	selected_interest.each do |interest|
  		matches << interest.users
  	end
  	if matches.present?
  		true
  		matches.uniq
  	else
  		[]
  	end
  end

end
