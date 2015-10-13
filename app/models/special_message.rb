class SpecialMessage < ActiveRecord::Base
	attr_accessor :city
	attr_accessor :profile
  belongs_to :interest
end
