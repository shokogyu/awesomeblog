class AccountActivationsController < ApplicationController

	def edit
		user = User.find_by(email: params[:email])

		if user && user.authenticate?(params[:id]) 		# This id is token
			user.update_attribute(:activated, true)		 	# update part of user
			user.update_attribute(:activated_at, Time.zone.now)
			#log_in user は　redirect_to login_pathと一緒？

			flash[:success] = "Account activated"
			#user.save(activated: true, activated_at: Time)
			redirect_to login_path
		else
			flash[:danger] = "Invalid activation link"
			redirect_to
		end
	end
end
