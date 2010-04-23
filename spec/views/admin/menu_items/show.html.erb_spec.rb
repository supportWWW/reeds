require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/menu_items/show.html.erb" do
  include Admin::MenuItemsHelper
  
  before(:each) do
    @menu_item = mock_model(MenuItem)
    @menu_item.stub!(:title).and_return("MyString")
    @menu_item.stub!(:page_id).and_return("1")
    @menu_item.stub!(:path).and_return("MyString")
    @menu_item.stub!(:parent_id).and_return("1")

    assigns[:menu_item] = @menu_item
  end

  it "should render attributes in <p>" do
    render "/admin/menu_items/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end

