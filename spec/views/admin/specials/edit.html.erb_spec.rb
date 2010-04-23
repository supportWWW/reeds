require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/specials/edit.html.erb" do
  include Admin::SpecialsHelper
  
  before do
    @special = mock_model(Special)
    @special.stub!(:title).and_return("MyString")
    @special.stub!(:text).and_return("MyText")
    assigns[:special] = @special
    @special.stub!(:image).and_return(nil)
    @special.stub!(:enabled).and_return(true)
    @special.stub!(:slideshow).and_return(true)
  end

  it "should render edit form" do
    render "/admin/specials/edit.html.erb"
    
    response.should have_tag("form[action=#{admin_special_path(@special)}][method=post]") do
      with_tag('input#special_title[name=?]', "special[title]")
      with_tag('textarea#special_text[name=?]', "special[text]")
    end
  end
end


