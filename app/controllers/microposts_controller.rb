class MicropostsController < ApplicationController

	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: [:destroy]


	def create
		@micropost = current_user.microposts.build(micropost_params) # new
		if @micropost.save
			flash[:success] = "Your new post is created." # success -> green, danger -> red bootstrap func
			redirect_to root_path
		else
			@feed_items = current_user.feed.paginate(page: params[:page])
			render 'static_pages/home' #root_path
		end
	end

	def destroy
		@micropost.destroy
		flash[:success] = "Micropost deleted."
		redirect_to request.referrer || root_path	
	end	


	private

	def micropost_params
		params.require(:micropost).permit(:content, :picture)
	end

	def correct_user
		@micropost = current_user.microposts.find_by(id: params[:id])
		redirect_to root_path if @micropost.nil?

		#micropost = Micropost.find(params[:id])
		# @micropost = Micropost.find(params[:id])
		# unless current_user == @micropost.user
		### unless current_user.id == @micropost.user_id
		# 	redirect_to root_path
		# end

		#redirect_to root_path unless current_user?(@micropost.user)

	end

end
