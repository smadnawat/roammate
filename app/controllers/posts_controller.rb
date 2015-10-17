class PostsController < ApplicationController
	before_filter :check_user, :only => [:create_post, :get_posts]

	def create_post
		@post = @user.posts.build(title: params[:title], content: params[:content], image: params[:image],user_type: "user")
		if @post.save
			render :json => {:response_code => 200,:message => "Post successfully created", :post => @post}
		else
			render :json => {:response_code => 500, :message => "Something went wrong."}
		end
	end

	def get_posts
		blocked_user_list(@user)
		@arr.present? ? @posts = Post.where('user_id NOT IN (?)', @arr ).order(created_at: "desc").paginate(:page => params[:page], :per_page => params[:size]) : @posts = Post.all.order(created_at: "desc").paginate(:page => params[:page], :per_page => params[:size])
		@max = @posts.total_pages
		@total_entries = @posts.total_entries
		@arr = []
		@posts.each do |p|
			@post = {}
			@post["post_id"] = p.id
			@post["title"] = p.title
			@post["content"] = p.content
			@post["image"] = p.image.url
			@post["created_at"] = p.created_at.to_i
			@points = user_points(User.find(p.user_id))
			@post["user"] = p.user.profile.attributes.merge(:points =>  @points, :online_status => p.user.online)
			@arr << @post
		end
		render :json => {:response_code => 200,:message => "All posts fetched successsfully.", :posts => @arr, :pagination => { :page => params[:page], :size=> params[:size], :max_page => @max, :total_entries => @total_entries} }
	end

	def admin_post
		render :json => {:response_code => 200,:message => "Admin posts fetched successsfully.", :admin_post => Post.where(admin_user_id: 1).as_json(only: [:content, :admin_user_id, :user_type]) }
	end

end
