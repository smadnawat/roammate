ActiveAdmin.register_page "Chat" do
  menu false
	content do
		@user1 = User.find(params[:user1])
		@user2 = User.find(params[:user2])
		@group = Group.where(group_name: [@user1.id.to_s, @user2.id.to_s], group_admin: [@user1.id, @user2.id]).first
		p "++++++++++++++++++#{@group.inspect}"
		@sendmsgs = @user1.messages.where("user_id = ? and group_id = ?",params[:user1], @group.id).order(:created_at)
		@rcvmsgs = @user2.messages.where("user_id = ? and group_id = ?",params[:user2], @group.id).order(:created_at)
		@msgs = []
		p "+++++++++#{@sendmsgs.inspect}++++++++++++++++++++"
		if !@sendmsgs.blank?
			@sendmsgs.each do |s|
			 @msgs << s
		    end
        end
        if !@rcvmsgs.blank?
        	@rcvmsgs.each do |r|
        		@msgs << r
        	end
        end
       
		table :class => "" do
				if !@msgs.blank?
			    @msgs.each do |m|
	       	tr do
	       	  th { m.user.profile.first_name }
	          td { m.content}
	      	end
			  end
        else
        	tr do
		        th { "No conversion to show" }
		      end
			end
	  end 
	end

	controller do
      def index
        if current_admin_user.is_admin 
         super
        else
         redirect_to :back ,:alert => "You are not allowed to access this Page!"
        end
      end
    end

end