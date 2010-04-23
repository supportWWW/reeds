require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/calculators/_monthly_payment.html.erb" do
  
  before(:each) do
  end

  it "should render monthly payment amount" do
    render :partial => "/calculators/monthly_payment.html.erb", :locals => { :purchase_price => 142995 }
    response.should have_text(/142995/)
    response.should have_tag("span[id=?]", "approximate_monthly_payment")
    response.should have_text(/3392/) # total
  end
  
end

