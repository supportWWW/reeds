require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/pages/show.html.erb" do
  include PagesHelper
  
  before(:each) do
    @page = mock_model(Page)
    @page.stub!(:title).and_return("MyString")
    @page.stub!(:title_permalink).and_return("MyString")
    @page.stub!(:text).and_return("MyText")
    @page.stub!(:image).and_return(mock_model(Image, :public_filename => ""))
    @page.stub!(:rendered_text).and_return("MyText")

    assigns[:page] = @page
  end

  it "should render attributes in <p>" do
    render "/pages/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
  end
end

