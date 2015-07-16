class UsersController < ApplicationController

	def destroy_users
		@user = User.find(params[:id])
		@rates = Rating.where('rater_id = ?', @user.id)
		@rates.destroy_all
		@user.destroy
		redirect_to admin_profiles_path
	end
end
