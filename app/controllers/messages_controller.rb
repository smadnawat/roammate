class MessagesController < ApplicationController

	include ApplicationHelper
	before_filter :check_user, :only => [:delete_chat, :user_inbox, :create_new_message, :delete_message, :create_new_group, :special_messages,:get_messages]

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
		@user = User.includes(:groups,:profile,:messages).where(:id => params[:user_id]).first
		# blocked_user_list(@user)
		# @arr.present? ? @groups = @user.groups.where('group_admin NOT IN (?)', @arr).paginate(:page => params[:page], :per_page => params[:size]) : 
		@groups = @user.groups.paginate(:page => params[:page], :per_page => params[:size])
		# @arr.present? ? @groups = @user.groups.where('group_admin NOT IN (?)',@arr )&@user.groups.where('group_admin NOT IN (?)',@arr.map{|x| x.to_s} ).paginate(:page => params[:page], :per_page => params[:size]) : @groups = @user.groups.paginate(:page => params[:page], :per_page => params[:size])
		@inb= []
		@groups.includes(:users, :messages).each do |g|
			g.users.each do |snd|
				@grp_name =  g.users.where('id != ?', @user.id).map {|x| x.profile.first_name}.join(",")
			end
		  	user_list = {}
			@all_messages = Message.where(id: (g.message_counts.where("user_id = ? and is_delete = ?", @user.id, false).pluck(:message_id)))
			@mg = @all_messages.order("created_at ASC").last
			@quee = Question.where('interest_id = ? and status = ?',@user.active_interest, true ).last
			@mg.present? ? user_list["last_message"] = @mg.attributes.slice("content").merge!("created_at"=> @mg.created_at.to_i) : user_list["last_message"] = (@quee.present? ?  @quee.slice().merge!("created_at"=> g.created_at.to_i, "content" => @quee.question) : nil)
			user_list["group_id"] = g.id
			user_list["group_name"] = @grp_name
			g.users.count == 2 ? chat_type = "single" : chat_type = "multiple"
			user_list["group_type"] = chat_type
			user_list["total_unread_message_count"] = (MessageCount.where('is_read = ? and user_id = ? and group_id = ?', false, @user.id, g.id ).count)
			if @user.id == g.group_admin
				@upro = User.find_by_id(g.group_name.to_i)
				@p = point_algo(@user, @upro )
				@prf = @upro.profile
				user_list["user"] = @prf.attributes.slice("id","first_name","last_name","image","gender","status","user_id").merge!("created_at"=> @prf.created_at.to_i , "points" => @p, "online_status" => @upro.online)
			else
				@upro = User.find_by_id(g.group_admin)
				@points = point_algo(@user, @upro)
				@pp = @upro.profile
				user_list["user"] = @pp.attributes.slice("id","first_name","last_name","image","gender","status","user_id").merge!("created_at"=> @pp.created_at.to_i , "points" => @points, "online_status" => @upro.online)
			end
			@inb << user_list
		end
		@max = @groups.total_pages
		@total_entries = @groups.total_entries
			render :json => {
										:response_code => 200,
										:message => "data fetched successfully.", 
										:inbox => (@inb.compact.sort_by { |k| k["last_message"].present? ? k["last_message"]["created_at"] : 1111111111111111111111 }).reverse ,
										:pagination => { :page => params[:page], :size=> params[:size], :max_page => @max, :total_entries => @total_entries}
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
												:message => "Messages not present"
												}
			end
		else
			render :json => {
											:response_code => 500,
											:message => "Your active interest not present"
											}
		end
	end

	def get_messages
		@group = Group.includes(:users).find_by_id(params[:group_id])
		if @group.present?
			@qs = Question.where('interest_id = ? and status = ?',@user.active_interest, true )
		  @get_default_quetions = []
		  @qs.each do |q|
		  	@get_default_quetions << q.attributes.slice("id","question","interest_id","status").merge!("created_at"=> q.created_at.to_i)
		  end
			@get_previous_messages = Message.includes(:user).where(id: (@group.message_counts.where("user_id = ? and is_delete = ?", @user.id, false).pluck(:message_id))).order("created_at DESC").paginate(:page => params[:page], :per_page => params[:size])
			@msg_cnt = MessageCount.where("group_id = ? and user_id = ? and is_read = ?", @group.id, @user.id, false)
			@msg_cnt.update_all(is_read: true) if @msg_cnt.present?
			@max = @get_previous_messages.total_pages
			@total_entries = @get_previous_messages.total_entries
			m = []
			if @get_previous_messages.present?
				@get_previous_messages.each do |msgs|
					# msgs.group.users.each do |read|
						# msgs.update_attributes(status: true) if (msgs.user_id != @uesr.id)
					# end
					m << msgs.user.profile.attributes.merge(:message => msgs.attributes.slice("id","content").merge!("created_at"=> msgs.created_at.to_i) )
				end
			end
			if @group.users.count == 2
				chat_type = "single"
				group_user_id = @group.users.where("id != ?", @user.id).first.id
			else
				chat_type = "multiple"
				group_user_id = nil
			end
			render :json => {
							:response_code => 200,
							:message => "Message list",
							:predefined_messages => @get_default_quetions,
							:chat_type => chat_type,
							:group_user_id => group_user_id,
							:user_messages => m,
							:pagination => { :page => params[:page], :size=> params[:size], :max_page => @max, :total_entries => @total_entries}
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
				@message = @user.messages.build(content: params[:message_content], group_id: @group.id, image: params[:image])
				if @message.save
					# @group.users.where('id != ?', @user.id).each do |g_user|
					@group.users.each do |g_user|
						@group.message_counts.create(user_id: g_user.id, message_id: @message.id, is_read: false)
					end
					@user.points.create(:pointable_type => "Reply first to ice breaker message") if !@user.points.where(:pointable_type => "Reply first to ice breaker message").present?	
					@alert = "send message"
					@group_users = @group.users.where('id != ?', @user.id)
					@group_users.each do |snd|
						@group_name =  @group.users.where('id != ?', @user.id).map {|x| x.profile.first_name}.join(",")
						@type = "Send message"
						@badge = Notification.where("reciever = ? and status = ?",snd.id ,false).count
            snd.devices.each {|device| (device.device_type == "android") ? AndroidPushWorker.perform_async(snd.id, "#{@user.profile.first_name}: #{@message.content}", @badge, nil, nil, @type, device.device_id, @user.profile.image, @group_name, @group.id, nil ) : ApplePushWorker.perform_async( snd.id, "#{@user.profile.first_name}: #{@message.content}", @badge, nil, nil, @type, device.device_id, nil, @group_name, @group.id, nil ) } if snd.message_notification
          end
				end
				message = "Message successfully created"
				code = 200
			end
			render :json => {
							:response_code => code,
							:message => message
							}
		else
			render :json => {
							:response_code => 500,
							:message => "Group not found."
							}
		end
	end

	def delete_chat
		if @group = Group.find_by_id(params[:group_id])
			@message_cnt = MessageCount.where("group_id = ? and user_id = ?", @group.id, @user.id)
			@message_cnt.update_all(is_delete: true, is_read: true ) if @message_cnt.present?
			render :json => {:response_code => 200,	:message => "Chat deleted successfully." }
		else
			render :json => {:response_code => 500,	:message => "Group not found." }
		end
	end

	def delete_message
		if @message = Message.find_by_id_and_user_id(params[:message_id], @user.id)
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
