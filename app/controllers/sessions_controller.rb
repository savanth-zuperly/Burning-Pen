class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			flash[:notice] = "Logged in Successfully"
			session[:user_id] = user.id
			redirect_to user
		else
			flash.now[:alert] = "You have entered either wrong email or password"
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
    	flash[:notice] = "Logged out"
    	redirect_to root_path
	end
end