require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/specials/show.html.erb" do
  include SpecialsHelper
  
  before(:each) do
    @special = mock_model(Special)
    @special.stub!(:title).and_return("MyString")
    @special.stub!(:title_permalink).and_return("MyString")
    @special.stub!(:text).and_return("MyText")
    @special.stub!(:image).and_return(mock_model(Image, :public_filename => ""))
    @special.stub!(:rendered_text).and_return("MyText")

    assigns[:special] = @special
  end

  it "should render attributes in <p>" do
    render "/specials/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
  end
end

