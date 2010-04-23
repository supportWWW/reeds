require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/categories/show.html.erb" do
  include Admin::CategoriesHelper
  
  before(:each) do
    @category = mock_model(Category)
    @category.stub!(:name).and_return("MyString")

    assigns[:category] = @category
  end

  it "should render attributes in <p>" do
    render "/admin/categories/show.html.erb"
    response.should have_text(/MyString/)
  end
end

