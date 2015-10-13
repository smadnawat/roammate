class SpecialMessage < ActiveRecord::Base
	attr_accessor :city
  belongs_to :interest
end
