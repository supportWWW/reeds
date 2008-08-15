require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/newsletters/subscribe" do
  before(:each) do
    render 'newsletters/subscribe'
  end
  
  it "should display heading" do
    response.should have_tag('h2', %r[Newsletter Subscription])
  end
end
