class MessageCount < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  belongs_to :message
end
