class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show]
	def new
		render "users/new"
	end
	def create
		user = User.create(
			name: params[:name],
			email: params[:email],
			password: params[:password],
			password_confirmation: params[:password_confirmation]
			)
		if user.errors.any?
			flash[:errors] = user.errors.full_messages
			redirect_to "/signup"
		else
			last_user = User.last
			session[:user_id] = last_user.id
			redirect_to "/users/#{last_user.id}"
		end
	end
	def show
		@user = User.find(params[:id])
		render "users/show"
	end
end
