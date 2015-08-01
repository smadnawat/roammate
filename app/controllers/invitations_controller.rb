class InvitationsController < ApplicationController

	before_filter :check_user, :only => [:select_user_to_add]



end
 	