class InvitationsController < ApplicationController

	before_filter :check_user, :only => [:get_roammates_to_add_in_group, :add_member_as_roammate, :accept_or_decline_invitation, :add_member_to_group]

	def add_member_as_roammate
		@member = User.find_by_id(params[:member_id])
		if @member.present?
			if Invitation.find_by_user_id_and_reciever(@user, @member) || Invitation.find_by_user_id_and_reciever(@member, @user)
				message = "Already invited this member as your roammate"
				code = 400
			else
				@roam_member = @user.invitations.create(reciever: @member.id, status: false)
				@alert = "Send chat"
				@notification =Notification.create_notification(@user,@member,@alert)
				@user.points.create(:pointable_type => "Send chat invite")
				message = "Invitation successfully sent."
				code = 200
			end
			render :json => {:response_code => code,:message => message}
		else
			render :json => {:response_code => 500,:message => "Something went wrong."}
		end
	end

	def accept_or_decline_invitation
		@member = User.find_by_id(params[:member_id])
		if @member.present? && @member.invitations.present?
			@invitation = Invitation.find_by_user_id_and_reciever_and_status(@member,@user,false)
			if @invitation.present? && params[:action_type].present?
				if params[:action_type] == "Accept"
					@invitation.update_attributes(status: true)
					@group = Group.create(group_admin: @member.id, group_name: "#{@user.id}")
					@group.users << @member
					@group.users << @user
					@alert = "accept chat"
					@notification =Notification.create_notification(@user,@member,@alert)
					@user.points.create(:pointable_type => "Accept Chat invite")
					message = "Successfully accepted invitation"
					code = 200
				elsif params[:action_type] == "Decline"
					@invitation.destroy
					message = "Successfully declineded invitation"
					code = 200
				end
			else
				message = "Already accepted this invitation"
				code = 400
			end
			render :json => {:response_code => code,:message => message}
		else
			render :json => {:response_code => 500, :message => "Something went wrong."}
		end
	end

	def get_roammate_to_add_in_group
		@members = Invitations.where("(user_id = ? or reciever = ?) and status = ?", @user.id, @user.id, true)
		@ids = @members.pluck(:user_id) + @members.pluck(:reciever)	- [@user.id]
		if @ids.present?
			friends = []
			@ids.uniq.each do |user|
				friends << Profile.find_by_id(user)
			end
			render :json => {:response_code => 200,:message => "Member successfully added in group.", :members => friends}
		else
			render :json => {:response_code => 500, :message => "Something went wrong."}
		end
	end

	def add_member_to_group
		@member = User.find_by_id(params[:member_id])	
		@group = Group.find_by_id(params[:group_id])
		if @member.present? && @group.present?
			@group.users << @member if !@group.users.include?(@member)
			render :json => {:response_code => 200,:message => "Member successfully added in group."}
		else
			render :json => {:response_code => 500, :message => "Something went wrong."}
		end
	end

end
 	