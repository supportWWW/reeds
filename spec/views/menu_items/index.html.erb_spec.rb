require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/menu_items/index.html.erb" do
  include MenuItemsHelper
  
  before(:each) do
    menu_item_98 = mock_model(MenuItem)
    menu_item_98.should_receive(:title).and_return("MyString")
    menu_item_98.should_receive(:path).and_return("MyString")
    menu_item_98.should_receive(:page).and_return( nil )
    menu_item_98.should_receive(:position).and_return( 1 )
    menu_item_98.should_receive(:parent).and_return( nil )
    
    menu_item_99 = mock_model(MenuItem)
    menu_item_99.should_receive(:title).and_return("MyString")
    menu_item_99.should_receive(:path).and_return("MyString")
    menu_item_99.should_receive(:page).and_return( nil )
    menu_item_99.should_receive(:position).and_return( 1 )
    menu_item_99.should_receive(:parent).and_return( nil )
    
    assigns[:menu_items] = [menu_item_98, menu_item_99]
  end

  it "should render list of menu_items" do
    render "/menu_items/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end

