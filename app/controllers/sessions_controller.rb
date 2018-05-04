class SessionsController < ApplicationController
  def new
  	#@user = User.new
  end

  def create
  	user = User.find_by(email: params[:session][:email])

  	if user && user.authenticate(params[:session][:password])  # ここに条件足すとエラーメッセージが複雑になる。
    #if user.authenticate(:password_digest) == user.password
      if user.activated?
    		log_in user
    		#flash[:success] = "You are successfully logged in!"
        #redirect_to user  # user_pathは持っていないといけない
    		redirect_back_or(user)
      else
          flash[:danger] = "Account not activated. Check your email for the activation link."
          redirect_to root_path # 'new'
      end
  	else
    		flash[:danger] = "User does'nt exsit."
    		render 'new'
    end
  end

  def destroy
  	log_out
  	flash[:danger] = "You are logged out!"
  	redirect_to root_path
  end

end
