class ReportsController < ApplicationController

	before_filter :check_user, :only => [:report_user]

	def report_user
		@report = @user.reports.create(member_id: params[:member_id]) if !(Report.find_by_member_id_and_user_id(params[:member_id], @user.id)).present?
		@report ? (render :json => { :response_code => 200, :response_message => "Report created successfully." }) : (render :json => { :response_code => 200, :response_message => "Already reported this member." })
	end

end
