require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/makes/index.html.erb" do
  include MakesHelper
  
  before(:each) do
    make_98 = mock_model(Make)
    make_98.should_receive(:name).and_return("MyString")
    make_98.should_receive(:common_name).and_return("MyString")
    make_98.should_receive(:website).and_return("MyString")
    make_99 = mock_model(Make)
    make_99.should_receive(:name).and_return("MyString")
    make_99.should_receive(:common_name).and_return("MyString")
    make_99.should_receive(:website).and_return("MyString")

    assigns[:makes] = [make_98, make_99]
  end

  it "should render list of makes" do
    render "/makes/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end

