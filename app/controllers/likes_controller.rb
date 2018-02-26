class LikesController < ApplicationController
	def create
		new_like = Like.create(user_id: params[:user_id], secret_id: params[:secret_id])
		redirect_to :back
 	 end

	def destroy
		#unlike = Like.where(user_id: params[:user_id]).where(secret_id: params[:secret_id])
		Like.find_by(user_id: params[:user_id], secret_id: params[:secret_id]).destroy
		#redirect_to :back
		#redirect_back(fallback_location: "/")
		redirect_to request.referer || "/"
		
  	end
end
