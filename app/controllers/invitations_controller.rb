class InvitationsController < ApplicationController

	before_filter :check_user, :only => [:add_member_as_roammate, :accept_invitation]

	def add_member_as_roammate
		@member = User.find_by_id(params[:member_id])
		if @member.present?
			if Invitation.find_by_user_id_and_reciever(@user, @member) || Invitation.find_by_user_id_and_reciever(@member, @user)
				message = "Already invited this member as your roammate"
				code = 400
			else
				@roam_member = @user.invitations.create(reciever: @member.id, status: false)
				@user.points.create(:pointable_type => "Send chat invite")
				message = "Invitation successfully sent."
				code = 200
			end
			render :json => {:response_code => code,:message => message}
		else
			render :json => {:response_code => 500,:message => "Something went wrong."}
		end
	end

	def accept_invitation
		@member = User.find_by_id(params[:member_id])
		if @member.present?
			@invitation = Invitation.find_by_user_id_and_reciever_and_status(@member,@user,false)
			if @invitation.present?
				@invitation.update_attributes(status: true)
				@user.points.create(:pointable_type => "Accept Chat invite")
				message = "Successfully accepted invitation"
				code = 200
			else
				message = "Already accepted this invitation"
				code = 400
			end
			render :json => {:response_code => code,:message => message}
		else
			render :json => {:response_code => 500, :message => "Something went wrong."}
		end
	end

end
 	