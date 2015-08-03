module ApplicationHelper

	def common_activities user,member
			@interest = User.find_by_id(user).interests&User.find_by_id(member).interests
	end

end
