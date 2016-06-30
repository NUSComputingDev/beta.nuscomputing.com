class Mc::BaseController < ApplicationController
	#before_action :authenticate_member!
	layout "mc"

	def home
    if !member_signed_in?
      redirect_to mc_login_path
    end
		@feedbacks = Feedback.all
	end
end
