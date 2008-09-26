require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/stocklists/subscribe" do
  before(:each) do
    render 'stocklists/subscribe'
  end
  
  it "should display heading" do
    response.should have_tag('h2', %r[Stock List Subscription])
  end
end
