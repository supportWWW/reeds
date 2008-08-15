require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/contact/sell_your_car" do
  before(:each) do
    render 'contact/sell_your_car'
  end
  
  it "should have a form" do
    response.should have_tag("form[action=?][method=?]", sell_your_car_path, "post")
  end
end
