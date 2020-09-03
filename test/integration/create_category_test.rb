require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest

  test "get new category form and create category" do
  	get "/categories/new/"
  	assert :success
  	assert_difference 'Category.count',1 do
  		post "/categories", params: { category: {name: "Travel"}}
  		assert_response :redirect
  	end
  	follow_redirect!
  	assert_match "Travel",response.body 
  end

  test "get new category form and reject an invalid category" do
  	get "/categories/new/"
  	assert :success
  	assert_no_difference 'Category.count' do
  		post "/categories", params: { category: {name: " "}}
  	end
  	assert_match   "errors",response.body
  	assert_select 'div.alert'
  	assert_select 'h4.alert-heading'
  end

end
