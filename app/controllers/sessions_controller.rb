class SessionsController < ApplicationController
	def new
		@guest = User.find_by(name: "Guest")
		render "sessions/new"
	end
	def create
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to "/users/#{user.id}"
		else 
			flash[:error] = "Invalid Email or Password Combo!"
			redirect_to '/'
		end
	end
	def destroy
		session[:user_id] = nil
		redirect_to "/"
	end
end
