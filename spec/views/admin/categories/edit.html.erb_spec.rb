require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/categories/edit.html.erb" do
  include Admin::CategoriesHelper
  
  before do
    @category = mock_model(Category)
    @category.stub!(:name).and_return("MyString")
    assigns[:category] = @category
  end

  it "should render edit form" do
    render "/admin/categories/edit.html.erb"
    
    response.should have_tag("form[action=#{admin_category_path(@category)}][method=post]") do
      with_tag('input#category_name[name=?]', "category[name]")
    end
  end
end


