class MessagesController < ApplicationController

	include ApplicationHelper
	before_filter :check_user, :only => [:user_inbox, :create_new_message]

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
		@friend_list = Invitation.where(' (user_id = ? or reciever = ?) and status = ? ',@user.id ,@user.id ,true)
		@users = @friend_list.pluck(:user_id) + @friend_list.pluck(:reciever)
		@all_friends = @users.uniq - [@user.id]
		user_list = []
		@all_friends.each do |t|
			user_list << User.find_by_id(t).profile
			@all_messages = Message.where('(user_id = ? and reciever = ?) or (user_id = ? and reciever = ?)',t,@user.id,@user.id,t)
			user_list << @all_messages.order("created_at ASC").last
			user_list << {:total_unread_message_count => @all_messages.where('status = ?', false).count}
			user_list << {:points => point_algo(@user.id, t)}
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

		@member = User.find_by_id(params[:member_id])
		if @member.present?
			if !(params[:message_content].present? || params[:image].present?)
				message = "Message not created"
				code = 400
			else
			@message = @user.messages.create(content: params[:message_content], reciever: params[:member_id], status: params[:status], image: params[:image])
				message = "Message successfully created"
				code = 200
			end

			@get_previous_messages = Message.where('(user_id = ? and reciever = ?) or (user_id = ? and reciever = ?)',params[:member_id],@user.id,@user.id,params[:member_id]).order("created_at ASC")

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

end
