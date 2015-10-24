class PostsController < ApplicationController
	before_filter :check_user, :only => [:create_post, :get_posts]

	def create_post
		@post = @user.posts.build(content: params[:content],user_type: "user")
		if @post.save
			render :json => {:response_code => 200,:message => "Post successfully created", :post => @post}
		else
			render :json => {:response_code => 500, :message => "Something went wrong."}
		end
	end

	def get_posts
		@arr = blocked_user_list(@user)
		@arr.present? ? @posts = Post.includes(user: [:profile]).where('user_id NOT IN (?)', @arr ).order(created_at: "desc").paginate(:page => params[:page], :per_page => params[:size]) : @posts = Post.all.includes(user: [:profile]).order(created_at: "desc").paginate(:page => params[:page], :per_page => params[:size])
		@max = @posts.total_pages
		@total_entries = @posts.total_entries
		@arr = []
		@posts.each do |p|
			@post = {}
			@post["user_id"] = p.user.id 
			@post["post_id"] = p.id
			@post["content"] = p.content
			@post["user_type"] = p.user_type
			@post["created_at"] = p.created_at.to_i
			@points = user_points(p.user, ServicePoint.all)
			@post["user"] = p.user.profile.attributes.merge(:points =>  @points, :online_status => p.user.online)
			@arr << @post
		end
		render :json => {:response_code => 200,:message => "All posts fetched successsfully.", :posts => @arr, :pagination => { :page => params[:page], :size=> params[:size], :max_page => @max, :total_entries => @total_entries} }
	end
end
