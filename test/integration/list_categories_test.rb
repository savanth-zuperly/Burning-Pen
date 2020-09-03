require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
  	@category = Category.create(name:"Sports")
  	@category2 = Category.create(name:"Travel")
  end

  test "listing categories" do
  	get '/categories'
  	assert_select "a[href=?]", category_path(@category), text: @category.name #to test the presence of the link to category show page 
  	assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end
end
