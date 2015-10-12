ActiveAdmin.register_page "Chat" do
  menu false
	content do
		@user1 = User.find(params[:user1])
		@user2 = User.find(params[:user2])
		@sendmsgs = @user1.messages.where("reciever = ?",params[:user2]).order(:created_at)
		@rcvmsgs = @user2.messages.where("reciever = ?",params[:user1]).order(:created_at)
		@msgs = []
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