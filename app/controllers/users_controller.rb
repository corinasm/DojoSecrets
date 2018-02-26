class UsersController < ApplicationController
	def index
		
	end

	def new
		#render a page where the new user creates an account
	end

	def create
		user = User.create(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
		# @user = User.new(user_params)
		# @user = User.create(user: current_user)
		if user.errors.any?
			flash[:errors] = user.errors.full_messages
			redirect_to :back
			
		else
			session[:user_id] = user.id
			@current_user = user
			redirect_to "/users/#{session[:user_id]}"
		end	
	end	
	
	def show
		@current_user = User.find(session[:user_id])
		@my_secrets = Secret.where(user_id: session[:user_id])
		secrets = Secret.all
		likes = Like.all
		# likes = Like.where(user_id: session[:user_id])


		@my_liked_secrets = []
		liked_secret ={}
		secrets.each do |secret|
			like_count= 0
			is_liked_bycrtuser = false
			likes.each do |like|
				if like.secret_id == secret.id
					like_count += 1		
					if like.user_id == @current_user.id	
						is_liked_bycrtuser = true
					end		
				end
			end	
			liked_secret = {:secret_liked => secret, :likes_count => like_count}	
			if is_liked_bycrtuser				
				@my_liked_secrets.push(liked_secret)
			end	
		end	
	end	

				
end
