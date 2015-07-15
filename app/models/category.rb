class Category < ActiveRecord::Base
	has_many :interests ,dependent: :destroy
	has_many :questions ,dependent: :destroy
	has_and_belongs_to_many :users , :join_table => "users_categories"
end
