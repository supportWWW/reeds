require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/categories/new.html.erb" do
  include CategoriesHelper
  
  before(:each) do
    @category = mock_model(Category)
    @category.stub!(:new_record?).and_return(true)
    @category.stub!(:name).and_return("MyString")
    assigns[:category] = @category
  end

  it "should render new form" do
    render "/categories/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", admin_categories_path) do
      with_tag("input#category_name[name=?]", "category[name]")
    end
  end
end


