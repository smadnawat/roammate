class Invitation < ActiveRecord::Base
  belongs_to :user
  has_many :points, as: :pointable, dependent: :destroy
end
