module ApplicationHelper

	def common_activities user,member
			@interest = User.find_by_id(user).interests & User.find_by_id(member).interests
	end

	def common_friends user,member
		@user1_invitation = Invitation.where('user_id = ? OR reciever = ? and status= ?', user, user,true)
		@user2_invitation = Invitation.where('user_id = ? OR reciever = ? and status= ?', member, member,true)
		@user1_friends = []
		@user2_friends = []
		@user1_invitation.each do |inv|
			if inv.user_id == user.to_i
				@user1_friends<<inv.reciever
			else
				@user1_friends<<inv.user_id
			end
		end
		@user2_invitation.each do |inv|
			if inv.user_id == member.to_i
				@user2_friends<<inv.reciever
			else
				@user2_friends<<inv.user_id
			end
		end 
		common_friends = @user1_friends & @user2_friends
	end

end
