require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/stocklists/confirmation" do
  before(:each) do
    render 'stocklists/confirmation'
  end
  
  it "should display heading" do
    response.should have_tag('h2', %r[Thank you])
  end
end
