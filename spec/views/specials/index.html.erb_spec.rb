require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/specials/index.html.erb" do
  include SpecialsHelper
  
  before(:each) do
    special_98 = mock_model(Special)
    special_98.should_receive(:title).and_return("MyString")
    special_98.stub!(:image)
    special_99 = mock_model(Special)
    special_99.should_receive(:title).and_return("MyString")
    special_99.stub!(:image)

    assigns[:specials] = [special_98, special_99]
    assigns[:specials].stub!( :total_specials ).and_return( 1 )
  end

  it "should render list of specials" do
    render "/specials/index.html.erb"
    response.should have_tag("tr>td", "MyString", 1)
    response.should have_tag("tr>td", "MyString", 1)
  end
end

