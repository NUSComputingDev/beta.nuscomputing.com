class Mc::LoginController < ApplicationController
	layout "mc"

	def login
		if member_signed_in?
			redirect_to mc_root_path
		end
	end
end
