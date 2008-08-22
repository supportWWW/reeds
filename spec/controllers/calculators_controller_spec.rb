require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CalculatorsController do

  #Delete these examples and add some real ones
  it "should use CalculatorsController" do
    controller.should be_an_instance_of(CalculatorsController)
  end


  describe "GET valid 'monthly_payment'" do
    it "should be successful" do
      xhr :get, 'monthly_payment', :form => { :purchase_price => "100000", :deposit => "0", :repayment_period => "24", :interest_rate => "16.5" }
      response.should be_success
      assigns(:form).valid?.should be_true
    end
  end

  describe "GET invalid 'monthly_payment'" do
    it "should be successful" do
      xhr :get, 'monthly_payment'
      response.should be_success
      assigns(:form).valid?.should be_false
    end
  end
end
