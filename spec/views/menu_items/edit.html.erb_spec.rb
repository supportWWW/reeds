require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/menu_items/edit.html.erb" do
  include MenuItemsHelper
  
  before do
    @menu_item = mock_model(MenuItem)
    @menu_item.stub!(:title).and_return("MyString")
    @menu_item.stub!(:page_id).and_return("1")
    @menu_item.stub!(:path).and_return("MyString")
    @menu_item.stub!(:parent_id).and_return("1")
    @menu_item.stub!(:position).and_return("2")
    assigns[:menu_item] = @menu_item
  end

  it "should render edit form" do
    render "/menu_items/edit.html.erb"
    
    response.should have_tag("form[action=#{menu_item_path(@menu_item)}][method=post]") do
      with_tag('input#menu_item_title[name=?]', "menu_item[title]")
      with_tag('input#menu_item_path[name=?]', "menu_item[path]")
    end
  end
end


