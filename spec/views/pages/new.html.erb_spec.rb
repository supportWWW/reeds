require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/pages/new.html.erb" do
  include PagesHelper
  
  before(:each) do
    @page = mock_model(Page)
    @page.stub!(:new_record?).and_return(true)
    @page.stub!(:title).and_return("MyString")
    @page.stub!(:title_permalink).and_return("MyString")
    @page.stub!(:text).and_return("MyText")
    @page.stub!(:rendered_text).and_return("MyText")
    assigns[:page] = @page
  end

  it "should render new form" do
    render "/pages/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", pages_path) do
      with_tag("input#page_title[name=?]", "page[title]")
      with_tag("textarea#page_text[name=?]", "page[text]")
    end
  end
end


