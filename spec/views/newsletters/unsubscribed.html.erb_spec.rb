require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/newsletters/unsubscribed" do
  before(:each) do
    render 'newsletters/unsubscribed'
  end
  
  it "should display heading" do
    response.should have_tag('h2', %r[Bye])
  end
end
