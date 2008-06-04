require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/categories/index.html.erb" do
  include CategoriesHelper
  
  before(:each) do
    category_98 = mock_model(Category)
    category_98.should_receive(:name).and_return("MyString")
    category_99 = mock_model(Category)
    category_99.should_receive(:name).and_return("MyString")

    assigns[:categories] = [category_98, category_99]
  end

  it "should render list of categories" do
    render "/categories/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
  end
end

