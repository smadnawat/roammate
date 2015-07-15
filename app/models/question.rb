class Question < ActiveRecord::Base
  belongs_to :interest
  # belongs_to :user
  belongs_to :category
end
