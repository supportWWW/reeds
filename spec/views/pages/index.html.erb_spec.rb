require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/pages/index.html.erb" do
  include PagesHelper
  
  before(:each) do
    page_98 = mock_model(Page)
    page_98.should_receive(:title).and_return("MyString")
    page_99 = mock_model(Page)
    page_99.should_receive(:title).and_return("MyString")

    assigns[:pages] = [page_98, page_99]
    assigns[:pages].stub!( :total_pages ).and_return( 1 )
  end

  it "should render list of pages" do
    render "/pages/index.html.erb"
    response.should have_tag("tr>td", "MyString", 1)
    response.should have_tag("tr>td", "MyString", 1)
  end
end

