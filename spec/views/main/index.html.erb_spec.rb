require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include SearchHelper

describe "/main/index" do
  before(:each) do
    render 'main/index'
  end
  
  it "should display search form" do
    response.should have_tag("form[action=?][method=?]", search_path, "post")
  end
end
