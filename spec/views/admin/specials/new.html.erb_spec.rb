require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/specials/new.html.erb" do
  include Admin::SpecialsHelper
  
  before(:each) do
    @special = mock_model(Special)
    @special.stub!(:new_record?).and_return(true)
    @special.stub!(:title).and_return("MyString")
    @special.stub!(:title_permalink).and_return("MyString")
    @special.stub!(:text).and_return("MyText")
    @special.stub!(:rendered_text).and_return("MyText")
    @special.stub!(:image).and_return(nil)
    @special.stub!(:enabled).and_return(true)
    @special.stub!(:slideshow).and_return(true)
    assigns[:special] = @special
  end

  it "should render new form" do
    render "/admin/specials/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", admin_specials_path) do
      with_tag("input#special_title[name=?]", "special[title]")
      with_tag("textarea#special_text[name=?]", "special[text]")
    end
  end
end


