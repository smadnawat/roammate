class PostsController < ApplicationController
	before_filter :check_user, :only => [:create_post, :create_comment]

	def create_post
		@post = @user.posts.build(title: params[:title], content: params[:content], image: params[:image])
		if @post.save
			render :json => {:response_code => 200,:message => "Post successfully created", :post => @post}
		else
			render :json => {:response_code => 500, :message => "Something went wrong."}
		end
	end

	def create_comment
		@post = Post.find_by_id(params[:post_id])
		if @post.present?
			@comment = @post.comments.create(:reply => params[:reply], :user_id => @user.id)
			render :json => {:response_code => 200,:message => "Comment successfully created", :comment => @comment}
		else
			render :json => {:response_code => 500, :message => "Something went wrong."}
		end
	end
end
