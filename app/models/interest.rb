class Interest < ActiveRecord::Base

  include ApplicationHelper
  mount_uploader :image, AvatarUploader
  mount_uploader :icon, IconUploader
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
  	@final = []
	  	selected_interest.each do |interest|
	  		interest.users.where('id != ?', user.id).each do |match|
	  			matches << match if match.current_city == user.current_city
	  		end
	  	end
  	matches.uniq.each do |t|
      @intr = {}
      @intr[:profile] = t.profile
      @intr[:points] = point_algo(t.id,user.id)
      t.interests&user.interests.each do |i|
        @interest = {}
        @interest[:id] =  i.id
        @interest[:interest_name] =  i.interest_name
        @interest[:image] =  i.image.url
        @interest[:icon] =  i.icon.url
        @interest[:banner] =  i.banner.url
        @interest[:description] =  i.description
      end
      @final << {:common_intrerest => @interest}
      @final << @intr
  	end
    @final
  end
  
end
