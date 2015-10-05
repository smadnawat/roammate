class CommentsController < ApplicationController

	def create_comment
		@post = Post.find_by_id(params[:post_id])
		if @post.present?
			@comment = @post.comments.create(:reply => params[:reply], :user_id => @user.id)
			arr = []
			@comments = @post.comments.each do |comment|
				com = {}
				com[:comment] = comment.reply
				com[:created_at] = comment.created_at
				com[:first_name] = comment.user.profile.first_name
				com[:last_name] = comment.user.profile.last_name
				com[:image] = comment.user.profile.image
				com[:email] = comment.user.profile.email
				com[:user_id] = comment.user_id
				arr << com
			end
			render :json => {:response_code => 200,:message => "Comment successfully created", :comments => arr }
		else
			render :json => {:response_code => 500, :message => "Post not found."}
		end
	end

	def get_comments
		@post = Post.find_by_id(params[:post_id])
		if @post.present?
			@arry =[]
			@post.comments.order(created_at: "desc").each do |c|
				@cm={}
				@cm["reply"] = c.reply
				@cm["created_at"] = c.created_at
				@cm["user"] = c.user.profile
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
