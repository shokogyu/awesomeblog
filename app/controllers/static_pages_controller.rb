class StaticPagesController < ApplicationController
  def home
  	if logged_in?
  		#@message = "Logged In."
  		#@user = current_user
        @micropost = current_user.microposts.build # new #Micropost.new
        @feed_items = current_user.feed
        @feed_items = Micropost.paginate(page: params[:page])
  	end
  end

  def help
  end

  def about
  	
  end
end
