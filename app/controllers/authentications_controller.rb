class AuthenticationsController < ApplicationController
	def ivle
		@user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in @user
      @user.remember_me!
      flash[:notice] = "Successfully logged in"
			redirect_to after_sign_in_path_for(@user)
		else
			flash[:alert] = "Cannot process your authentication request."
			redirect_to root_path
		end
	end

	def google_oauth2
		omniauth = request.env["omniauth.auth"]
		if Member.find_by(email: omniauth.info['email'])
			@member = Member.from_omniauth(request.env["omniauth.auth"])

			if @member.persisted?
				sign_in @member
				@member.remember_me!
				session["gollum.author"] = { name: @member.email, email: @member.email }
				flash[:notice] = "Successfully logged in"
				redirect_to mc_root_path
			else
				flash[:alert] = "Cannot process your authentication request."
				redirect_to mc_login_path
			end
		else
			flash[:alert] = "Cannot process your authentication request."
			redirect_to mc_login_path
		end
	end
end
