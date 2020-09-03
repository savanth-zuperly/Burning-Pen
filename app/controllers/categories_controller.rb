class CategoriesController < ApplicationController

	before_action :set_category, only: [:show,:edit,:update]
	before_action :require_admin, only: [:new,:create,:edit]

	def new
		@category = Category.new
	end

	def show
		@articles = @category.articles.paginate(page: params[:page], per_page: 5)
	end

	def index
		@categories = Category.paginate(page: params[:page], per_page: 5)
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:notice] = "Category created Successfully"
			redirect_to @category
		else
			render 'new'
		end
	end

	def edit 
	end

	def update
		if @category.update(category_params)
			flash[:notice] = "Category name updated Successfully"
			redirect_to @category
		else
			render 'edit'
		end
	end

	private

	def category_params
		params.require(:category).permit(:name)
	end

	def set_category 
		@category =  Category.find(params[:id])
	end

	def require_admin
		if !(logged_in? && current_user.admin?)
			flash[:alert] = "You don't have permission to create the category"
			redirect_to categories_path
		end
	end	

end