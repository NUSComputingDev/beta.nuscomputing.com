class Mc::BaseController < ApplicationController
	before_action :authenticate_member!
	layout "mc"

	def home
		@feedbacks = Feedback.all
	end
end
