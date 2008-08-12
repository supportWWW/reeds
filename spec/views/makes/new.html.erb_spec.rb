require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/makes/new.html.erb" do
  include MakesHelper
  
  before(:each) do
    @make = mock_model(Make)
    @make.stub!(:new_record?).and_return(true)
    @make.stub!(:name).and_return("MyString")
    @make.stub!(:common_name).and_return("MyString")
    @make.stub!(:website).and_return("MyString")
    assigns[:make] = @make
  end

  it "should render new form" do
    render "/makes/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", admin_makes_path) do
      with_tag("input#make_name[name=?]", "make[name]")
      with_tag("input#make_common_name[name=?]", "make[common_name]")
      with_tag("input#make_website[name=?]", "make[website]")
    end
  end
end


