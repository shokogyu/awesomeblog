module SessionsHelper
	def log_in(user)
		session[:user_id] = user.id		
	end

	def current_user
		#current_user = User.find(session[:user_id]) -> なかったらおちる
		#@current_user = @current_user || User.find_by(id: session[:user_id])
		@current_user ||= User.find_by(id: session[:user_id])
	end

	def current_user?(user)
		user == current_user			
	end	

	def logged_in? # ? returns true or false
		!!current_user
		# !current_user.nil?

	end

	def log_out # private method, users_controll
		session.delete(:user_id)
		@current_user = nil
	end


	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url) # we need this only one time
	end

	def store_location
		session[:forwarding_url] = request.url if request.get? # creating new session
	end
end

