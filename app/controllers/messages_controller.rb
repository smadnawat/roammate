class MessagesController < ApplicationController

	include ApplicationHelper
	before_filter :check_user, :only => [:user_inbox, :create_new_message, :delete_message, :create_new_group, :special_messages,:get_messages]

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
		@inb= []
		@groups.each do |g|
			user_list = {}
			@all_messages = g.messages
			@mg = @all_messages.order("created_at ASC").last
			user_list["last_message"] = @mg.attributes.slice("id","content","user_id","group_id").merge!("created_at"=> @mg.created_at.to_i)
			user_list["total_unread_message_count"] = @all_messages.where('status = ?', false).count
			if @user.id == g.group_admin
				@p = point_algo(@user.id, g.group_name.to_i)
				@prf = User.find_by_id(g.group_name.to_i).profile
				user_list["user"] = @prf.attributes.slice("id","first_name","last_name","image","gender","status","user_id").merge!("created_at"=> @prf.created_at.to_i , "points" => @p)
			else
				@points = point_algo(@user.id, g.group_admin)
				@pp = User.find_by_id(g.group_admin).profile
				user_list["user"] = @pp.attributes.slice("id","first_name","last_name","image","gender","status","user_id").merge!("created_at"=> @pp.created_at.to_i , "points" => @points)
			end
			@inb << user_list
		end
			render :json => {
								:response_code => 200,
								:message => "data fetched successfully.", 
								:inbox => @inb
							}
	
	end


	def special_messages
		@active_interest = Interest.find_by_id(@user.active_interest)
		if @active_interest.present?
			@active_messages = @active_interest.special_messages.where(status: true)
			if @active_messages.present?
				render :json => {
												:active_messages => @active_messages,
												:response_code => 200,
												:message => "Successfully fetched messages",
												}
			else
				render :json => {
												:response_code => 400,
												:message => "No record found."
												}
			end
		else
			render :json => {
											:response_code => 500,
											:message => "Something went wrong."
											}
		end
	end

	def get_messages
		@group = Group.find_by_id(params[:group_id])
		if @group.present?
			@qs = Question.where('interest_id = ? and status = ?',@user.active_interest, true )
		  @get_default_quetions = []
		  @qs.each do |q|
		  	@get_default_quetions << q.attributes.slice("id","question","interest_id","status").merge!("created_at"=> q.created_at.to_i)
		  end
			@get_previous_messages = Message.where('group_id = ?', @group.id).order("created_at ASC")
			m = []
			if @get_previous_messages.present?
				@get_previous_messages.each do |msgs|
					m << msgs.user.profile.attributes.merge(:message => msgs.attributes.slice("id","content").merge!("created_at"=> msgs.created_at.to_i) )
				end
			end
			render :json => {
							:response_code => 200,
							:message => "Message list",							
							:predefined_messages => @get_default_quetions,
							:user_messages => m
							}

		else
			render :json => {
							:response_code => 500,
							:message => "Group not found."
							}
		end
	end

	def create_new_message
		@group = Group.find_by_id(params[:group_id])
		if @group.present?
			if !params[:message_content].present?
				message = "Message not created"
				code = 400
			else
				@message = @user.messages.create(content: params[:message_content], group_id: @group.id, image: params[:image])
				@user.points.create(:pointable_type => "Reply first to ice breaker message") if !@user.points.where(:pointable_type => "Reply first to ice breaker message").present?	
				message = "Message successfully created"
				code = 200
				@get_previous_messages = Message.where('group_id = ?', @group.id).order("created_at ASC")
				@ms = []
				if @get_previous_messages.present?
					@get_previous_messages.each do |msgs|
						@ms << msgs.user.profile.attributes.merge(:message => msgs.attributes.slice("id","content").merge!("created_at"=> msgs.created_at.to_i) )
					end
				end
			end
			
			render :json => {
							:response_code => code,
							:message => message,
							:user_messages => @ms
							}
		else
			render :json => {
							:response_code => 500,
							:message => "Something went wrong."
							}
		end
	end


	def delete_message
		@message = Message.find_by_id_and_user_id(params[:message_id], @user.id)
		if @message.present?
			@message.destroy
			message = "Successfully deleted message"
			code = 200
		else
			message = "Message not found"
			code = 400
		end
		render :json => {
										:response_code => code,
										:message => message
										}
	end

end
