class Interest < ActiveRecord::Base
  belongs_to :category
  has_many :questions ,dependent: :destroy
  has_and_belongs_to_many :users , :join_table => "users_interests" 
end
