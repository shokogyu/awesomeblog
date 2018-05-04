class ApplicationController < ActionController::Base
	include SessionsHelper  # To be available anywhere

	private
		def logged_in_user
			unless logged_in?
			#if logged_in? == false
				store_location
				flash[:danger] = "Please log in."
				redirect_to "/login"
			end
		end
end
