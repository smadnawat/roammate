class InvitationsController < ApplicationController

	before_filter :check_user, :only => [:get_roammate_to_add_in_group, :add_member_as_roammate, :accept_or_decline_invitation, :add_member_to_group]

	def add_member_as_roammate
		@member = User.find_by_id(params[:member_id])
		if @member.present?
			if Invitation.find_by_user_id_and_reciever(@user, @member) || Invitation.find_by_user_id_and_reciever(@member, @user)
				message = "Already invited this member as your roammate"
				code = 400
			else
				@invitation = @user.invitations.create(reciever: @member.id, status: false)
				@alert = "Send chat"
				@notification = Notification.create_notification(@user,@member,@alert,@invitation.id) #if @member.friend_request_notification
				@user.points.create(:pointable_type => "Send chat invite")
				message = "Invitation successfully sent."
				code = 200
			end
			render :json => {:response_code => code,:message => message}
		else
			render :json => {:response_code => 500,:message => "Member not present."}
		end
	end

	def accept_or_decline_invitation
		@invitation = Invitation.find_by_id(params[:invitation_id])
		if @invitation.present? && params[:action_type].present?
			@notice = Notification.find_by_id(params[:notification_id])
			if params[:action_type] == "Accept"
				@notice.update_attributes(status: true, message: "#{@notice.user.profile.first_name.capitalize} is now your roammate")
				@invitation.update_attributes(status: true)
				@group = Group.create(group_admin: @invitation.user_id, group_name: "#{@user.id}")
				@group.users << @invitation.user
				@group.users << @user
				@alert = "accept chat"
				@notification = Notification.create_notification(@user,@invitation.user,@alert,@invitation.id)
				@user.points.create(:pointable_type => "Accept Chat invite")
				message = "Successfully accepted invitation"
				code = 200
			elsif params[:action_type] == "Decline"
				@invitation.destroy
				@notice.destroy
				message = "Successfully declineded invitation"
				code = 200
			end
		else
			message = "Already accepted this invitation"
			code = 400
		end
		render :json => {:response_code => code,:message => message}
	end

	def add_member_to_group
		@member = User.find_by_id(params[:member_id])	
		@group = Group.find_by_id(params[:group_id])
		if @member.present? && @group.present?
			@group.users << @member if !@group.users.include?(@member)
			render :json => {:response_code => 200,:message => "Member successfully added in group."}
		else
			render :json => {:response_code => 500, :message => "Member or group not exist."}
		end
	end

	def get_roammate_to_add_in_group
		@members = Invitation.where("(user_id = ? or reciever = ?) and status = ?", @user.id, @user.id, true).paginate(:page => params[:page], :per_page => params[:size])
		@max = @members.total_pages
		@total_entries = @members.total_entries
		@already_added_members = Group.find_by_id(params[:group_id]).users.pluck(:id)
		@ids = @members.pluck(:user_id) + @members.pluck(:reciever)	- [@user.id] - blocked_user_list(@user).uniq - @already_added_members
		if @ids.present?
			friends = []
			@ids.uniq.each do |user|
				friends << Profile.find_by_id(user)
			end
			render :json => {:response_code => 200,:message => "Member successfully fetched.", :members => friends,:pagination => { :page => params[:page], :size=> params[:size], :max_page => @max, :total_entries => @total_entries}}
		else
			render :json => {:response_code => 500, :message => "Members not found to add in group."}
		end
	end

end
	