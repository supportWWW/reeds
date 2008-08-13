require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/makes/show.html.erb" do
  include Admin::MakesHelper
  
  before(:each) do
    @make = mock_model(Make)
    @make.stub!(:name).and_return("MyString")
    @make.stub!(:common_name).and_return("MyString")
    @make.stub!(:website).and_return("MyString")

    assigns[:make] = @make
  end

  it "should render attributes in <p>" do
    render "/admin/makes/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end

