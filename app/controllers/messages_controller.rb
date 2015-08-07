class MessagesController < ApplicationController

	include ApplicationHelper
	before_filter :check_user, :only => [:user_inbox, :create_new_message, :delete_message, :create_new_group]

	def message_status
		@message = Question.find(params[:id])
		@message.status ? @message.update_attributes(:status => false) : @message.update_attributes(:status => true)
		redirect_to admin_messages_path
	end

	def special_message_status
		@message = SpecialMessage.find(params[:id])
		@message.status ? @message.update_attributes(:status => false) : @message.update_attributes(:status => true)
		redirect_to admin_special_messages_path
	end

	def delete_bad_rating
		rate = Rating.find(params[:id])
		rate.destroy
		redirect_to admin_chat_history_path
	end
	

	def user_inbox
		@groups = @user.groups
		user_list = []
		@groups.each do |g|
			@all_messages = g.messages
			user_list << @all_messages.order("created_at ASC").last
			user_list << {:total_unread_message_count => @all_messages.where('status = ?', false).count}
			if @user.id == g.group_admin
				user_list << {:points => point_algo(@user.id, g.group_name.to_i)}
				user_list << User.find_by_id(g.group_name.to_i).profile
			else
				user_list << {:points => point_algo(@user.id, g.group_admin)}
				user_list << User.find_by_id(g.group_admin).profile
			end
		end
		if user_list.present?
			render :json => {
												:response_code => 200,
												:message => "data fetched successfully.", 
												:inbox => user_list
											}
		else
			render :json => {
												:response_code => 400,
												:message => "No record found."
											}
		end
	end


	def create_new_message
		@group = Group.find_by_id(params[:group_id])
		if @group.present?
			if !(params[:message_content].present? || params[:image].present?)
				message = "Message not created"
				code = 400
			else
			@message = @user.messages.create(content: params[:message_content], group_id: @group.id, image: params[:image])
			@user.points.create(:pointable_type => "Reply first to ice breaker message")	
				message = "Message successfully created"
				code = 200
			end
			@get_default_quetions = Question.where('interest_id = ? and status = ?',@user.active_interest, true )
			@get_previous_messages = Message.where('group_id = ?', @group.id).order("created_at ASC")

		if @get_previous_messages.present?
			msg = []
			@get_previous_messages.each do |msgs|
				msg << msgs.user.profile
				msg << msgs
			end
			msg
		else
			msg
		end
			render :json => {
											:predefined_messages => @get_default_quetions,
											:response_code => code,
											:message => message,
											:user_messages => msg
											}
		else
			render :json => {
											:response_code => 500,
											:message => "Something went wrong."
											}
		end
	end

	# def delete_message
	# 	@message = Message.find_by_id_and_user_id(params[:message_id], @user.id)
	# 	if @message.present?
	# 		@message.destroy
	# 		message = "Successfully deleted message"
	# 		code = 200
	# 	else
	# 		message = "Message not found"
	# 		code = 400
	# 	end
	# 	render :json => {
	# 									:response_code => code,
	# 									:message => message
	# 									}
	# end

end
