class CommentsController < ApplicationController

before_filter :check_user, :only => [:create_comment, :get_comments]
	def create_comment
		if @post = Post.find_by_id(params[:post_id])
			@comment = @post.comments.create(:reply => params[:reply], :user_id => @user.id)
			render :json => {:response_code => 200,:message => "Comment successfully created"}
		else
			render :json => {:response_code => 500, :message => "Post not found."}
		end
	end

	def get_comments
		if @post = Post.includes(:comments).find_by_id(params[:post_id])
			@arry =[]
			@post.comments.order(created_at: "desc").each do |c|
				@cm={}
				@cm["reply"] = c.reply
				@cm["created_at"] = c.created_at
				@cm["user"] = c.user.profile.attributes.merge(:online_status => c.user.online)
				@arry << @cm
			end
			render :json => {:response_code => 200,:message => "Comments", :comments => @arry.reverse}
		else
			render :json => {:response_code => 500, :message => "Post not found."}
		end
	end

	def delete_comment
    @comment = Comment.find(params[:id])
    @comment.destroy
		redirect_to  admin_post_path(params[:post_id])
	end
end
