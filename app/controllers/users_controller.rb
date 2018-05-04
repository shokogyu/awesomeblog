class UsersController < ApplicationController
	# callback methods must be private
	before_action :logged_in_user, only: [:index, :edit, :update]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: [:destroy]

	def new
		@user = User.new
	end

	def index
		@users = User.paginate(page: params[:page])
	end

	def create
		@user = User.new(user_params)
		if @user.save
			UserMailer.account_activation(@user).deliver_now
			flash[:info] = "Please check your email and activate your account!" # success -> green, danger -> red bootstrap func
			#flash[:success] = "Welocome to Awesomeblog" # success -> green, danger -> red bootstrap func
			redirect_to root_path # root
			#redirect_to user_path(@user.id)
		else
			render "new"
		end
	end

	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(page: params[:page])

		#@relationship = current_user.active_relationships ==
		# @following = @user.active_relationships
		# @followers = @user.passive_relationships
		#@micoposts = Micropost.(user_id: current_user.id) ダメ	
		#@micoposts = @user.micropost	
	end

	def edit
		@user = User.find_by(id: current_user.id)
	end

	def update
		#@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Your profile is updated successfully!"
			redirect_to user_path(@user.id) # @userでもOK?
		else
			render "edit"
		end
		
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to users_path
	end

	def following
		@title = "following"
		@user = User.find(params[:id])
		@users = @user.following
		render 'show_follow'
	end

	def followers
		@title = "followers"
		@user = User.find(params[:id])
		@users = @user.followers
		render 'show_follow'
	end



	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	# def user_params_update
	# 	params.require(:user).permit(:name, :email)
	# end

	def correct_user
		@user = User.find(params[:id])
		redirect_to root_path unless @user == current_user
	end

	def admin_user
		redirect_to root_path unless current_user.admin?
	end

end
