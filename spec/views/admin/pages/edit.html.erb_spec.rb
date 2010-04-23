require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/pages/edit.html.erb" do
  include Admin::PagesHelper
  
  before do
    @page = mock_model(Page)
    @page.stub!(:title).and_return("MyString")
    @page.stub!(:text).and_return("MyText")
    @page.stub!(:image).and_return(nil)
    assigns[:page] = @page
  end

  it "should render edit form" do
    render "/admin/pages/edit.html.erb"
    
    response.should have_tag("form[action=#{admin_page_path(@page)}][method=post]") do
      with_tag('input#page_title[name=?]', "page[title]")
      with_tag('textarea#page_text[name=?]', "page[text]")
    end
  end
end


