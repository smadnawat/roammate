class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  has_many :points, as: :pointable, dependent: :destroy
end
