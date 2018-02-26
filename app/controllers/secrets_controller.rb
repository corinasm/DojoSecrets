class SecretsController < ApplicationController
	def index
		@current_user = User.find(session[:user_id])
		@secrets = Secret.all
		puts @secrets
		@likes = Like.all
		puts @likes

		@secrets_wlikes = []
		secret_dict = {}
		@secrets.each do |secret|
			is_liked_bycrtuser = false
			like_count = 0
			@likes.each do |like|
				if like.user_id == @current_user.id and like.secret_id == secret.id
					is_liked_bycrtuser = true		
				end	
				if like.secret_id == secret.id
					like_count += 1
				end	
			end	
			secret_dict = {:secretx => secret, :is_liked => is_liked_bycrtuser, :likes_count => like_count}
			@secrets_wlikes.push(secret_dict)
		end	
	end

  	def create
		current_user = User.find(session[:user_id])
		# user_id = current_user.id
		secret = Secret.create(content: params[:content], user_id: current_user.id)
		redirect_to :back
  	end  

  	def destroy
		Secret.find(params[:id]).destroy
		redirect_to :back
  	end

end
