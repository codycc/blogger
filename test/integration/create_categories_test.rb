require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  test 'get new category form and create category' do
    # going to new category path
    get new_category_path
    # getting the new form
    assert_template 'categories/new'
    # posting to new form creating new category sports
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: 'sports'}
    end
    # redirecting to index page
    assert_template 'categories/index'
    # which should have category sports
    assert_match 'sports', response.body
  end

  test 'invalid category submission results in failure' do
    # going to new category path
    get new_category_path
    # getting the new form
    assert_template 'categories/new'
    # posting to new form creating new category sports
    assert_no_difference 'Category.count' do
      post categories_path, category: {name: ''}
    end
    # redirecting to index page
    assert_template 'categories/new'
    # which should have category sports
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'

  end
end
