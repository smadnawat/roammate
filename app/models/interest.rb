class Interest < ActiveRecord::Base

  include ApplicationHelper
  mount_uploader :image, AvatarUploader
  mount_uploader :icon, AvatarUploader
  mount_uploader :banner, AvatarUploader
  belongs_to :category
  has_many :questions ,dependent: :destroy
  has_many :special_messages ,dependent: :destroy
  has_and_belongs_to_many :users , :join_table => "users_interests" 
  before_destroy :delete_interest_users
  validates_presence_of  :image,:icon,:banner

  def delete_interest_users
    @users = self.users
    @users.update_all(:active_interest => nil)
    @action = self.users - @users
  end

  def self.view_matches_algo selected_interest, user
  	matches = []
  	final = []
	  	selected_interest.each do |interest|
	  		interest.users.where('id != ?', user.id).each do |match|
	  			matches << match if match.current_city == user.current_city
	  		end
	  	end
  	matches.uniq.each do |t|
  		final << t.profile
      final << {:points => point_algo(t.id,user.id)}
  		final << {:common_intrerest => t.interests&user.interests}
  	end
  	final
  end
  
end
