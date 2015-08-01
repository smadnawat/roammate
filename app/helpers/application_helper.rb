module ApplicationHelper

	def common_activities user member
			@interest = User.find_by_id(user).interests&User.find_by_id(member).interests
	end

	def common_friends user member
		@invitation = Invitation.where('user_id = ? OR receiver = ?', user, user)
			if @invitation.present?
				common_friends = []
				@invitation.each do |user|
					common_friends << user.user.profile
				end
			end
			common_friends.uniq
	end
end
