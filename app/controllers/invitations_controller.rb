class InvitationsController < ApplicationController

	before_filter :check_user, :only => [:select_user_to_add]

	def select_user_to_add
		if User.find_by_id(params[:receiver_id]).present?
		@invitation = @user.invitations.create(reciever: params[:receiver_id], status: false)
			render :json => { :responce_code => 200, :responce_message => "User successfully added", }
		else
			render :json => { :responce_code => 500, :responce_message => "Something went wrong", }
		end
	end

end
 	