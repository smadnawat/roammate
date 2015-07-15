class MessagesController < ApplicationController

	def delete_bad_rating
		rate = Rating.find(params[:id])
		rate.destroy
		redirect_to admin_chat_history_path
	end

end
