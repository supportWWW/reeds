require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/menu_items/new.html.erb" do
  include Admin::MenuItemsHelper
  
  before(:each) do
    @menu_item = mock_model(MenuItem)
    @menu_item.stub!(:new_record?).and_return(true)
    @menu_item.stub!(:title).and_return("MyString")
    @menu_item.stub!(:page_id).and_return("1")
    @menu_item.stub!(:path).and_return("MyString")
    @menu_item.stub!(:parent_id).and_return("1")
    @menu_item.stub!(:position).and_return( 1 )
    
    assigns[:menu_item] = @menu_item
  end

  it "should render new form" do
    render "/admin/menu_items/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", admin_menu_items_path) do
      with_tag("input#menu_item_title[name=?]", "menu_item[title]")
      with_tag("input#menu_item_path[name=?]", "menu_item[path]")
    end
  end
end


