class User < ActiveRecord::Base
	has_one :profile , dependent: :destroy
	has_and_belongs_to_many :cities , :join_table => "users_cities" 
	has_and_belongs_to_many :categories , :join_table => "users_categories"
	has_and_belongs_to_many :interests , :join_table => "users_interests" 
	has_and_belongs_to_many :groups ,:join_table => "users_groups"
	# has_many :questions ,dependent: :destroy
	has_many :points ,dependent: :destroy
	has_many :feedbacks ,dependent: :destroy
	has_many :messages ,dependent: :destroy 
	has_many :invitations ,dependent: :destroy
	has_many :ratings ,dependent: :destroy
	has_many :posts ,dependent: :destroy
	has_many :comments ,dependent: :destroy 
end
