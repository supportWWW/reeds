require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/specials/index.html.erb" do
  include Admin::SpecialsHelper
  
  before(:each) do
    special_98 = mock_model(Special)
    special_98.should_receive(:title).and_return("MyString")
    special_98.stub!(:image)
    special_98.stub!(:enabled?).and_return(true)
    special_98.stub!(:slideshow?).and_return(true)
    special_99 = mock_model(Special)
    special_99.should_receive(:title).and_return("MyString")
    special_99.stub!(:image)
    special_99.stub!(:enabled?).and_return(true)
    special_99.stub!(:slideshow?).and_return(true)

    assigns[:specials] = [special_98, special_99]
    assigns[:specials].stub!( :total_pages ).and_return( 1 )
  end

  it "should render list of specials" do
    render "/admin/specials/index.html.erb"
    response.should have_tag("tr>td", "MyString", 1)
    response.should have_tag("tr>td", "MyString", 1)
  end
end

