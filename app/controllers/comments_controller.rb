class CommentsController < ApplicationController
	def delete_comment
        @comment = Comment.find(params[:id])
        @comment.destroy
		redirect_to  admin_post_path(params[:post_id])
	end
end
