class UsersController < ApplicationController
	before_action :set_user, only: [:edit,:update,:show]

	def show
		@articles = @user.articles.paginate(page: params[:page], per_page: 5)
	end

	def new
		@user = User.new
	end

	def edit
	end

	def index
		@users = User.paginate(page: params[:page], per_page: 5)
	end

	def update
		if @user.update(user_params)
			flash[:notie] = "Update Successfull"
			redirect_to	@user
		else
			render 'edit'
		end
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notie] = "Signup Successful. Welcome to Blogosphere #{@user.username} :)"
			redirect_to articles_path
		else
			render 'new'
		end
	end

	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:username,:email,:password)	
	end
end