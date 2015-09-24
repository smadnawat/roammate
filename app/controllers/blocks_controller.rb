class BlocksController < ApplicationController

	before_filter :check_user, :only => [ :block_unblock_users ]
	
	def block_unblock_users
		@member = User.find_by_id(params[:member_id])
		if @member.present?
			@block = Block.find_by_user_id_and_member_id(params[:user_id], params[:member_id])
			@block.present? ? @block.update_attributes(:is_block => params[:status]) : @user.blocks.create(member_id: params[:member_id],is_block: params[:status])
			params[:status] == "true" ? @status = "Blocked" : @status = "Unblocked"
			render :json => {:response_code => 200,:message => "User #{@status} Successfully", :status => @status }
		else
			render :json => {:response_code => 500,:message => "Something went wrong." }
		end
	end

end