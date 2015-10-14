class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  has_many :message_counts , dependent: :destroy
end
