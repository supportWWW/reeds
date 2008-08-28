require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Calculator do

  it "should be 3392" do
    Calculator.monthly_payment(142995, 14300, 54, 16.5).should == 3392
  end
  
end
