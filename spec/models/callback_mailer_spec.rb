require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CallbackMailer do

  before(:each) do  
    ActionMailer::Base.delivery_method = :test  
    ActionMailer::Base.perform_deliveries = true  
    ActionMailer::Base.deliveries = []
  end

  it "should generate used email" do
    mail = CallbackMailer.deliver_requested(CallbackForm.new(:first => "Joerg", :last => "Diekmann", :phone => "0214465543", :vehicle => "Isuzu"), ["Bob", "Mary"])
    ActionMailer::Base.deliveries.size.should == 1
    mail.to.should == ["direct@reeds.co.za"]
    mail.body.should =~ /Isuzu/
    mail.body.should =~ /Bob and Mary/
  end
end