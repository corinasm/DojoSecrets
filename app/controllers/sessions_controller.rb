class SessionsController < ApplicationController
    def new
        # render login page
    end

    def create      
        @current_user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
        if @current_user
            session[:user_id]= @current_user.id
            puts session[:user_id]
            redirect_to "/users/#{@current_user.id}"
        else 
            flash[:errors]  = "Invalid email or password. Try again"  
            redirect_to :back
        end    

    end

    def delete
        session[:user_id] = nil
        redirect_to '/sessions/new'
    end

end