require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/stocklists/unsubscribed" do
  before(:each) do
    render 'stocklists/unsubscribed'
  end
  
  it "should display heading" do
    response.should have_tag('h2', %r[Bye])
  end
end
