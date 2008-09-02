require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StockListMailer do

  before(:each) do  
    ActionMailer::Base.delivery_method = :test  
    ActionMailer::Base.perform_deliveries = true  
    ActionMailer::Base.deliveries = []  
  end

  it "should generate email" do
    mail = StockListMailer.deliver_list("Joerg", "email1@spam.com", ["Audi A4"])
    ActionMailer::Base.deliveries.size.should == 1
    mail.to.should == ["joergd@pobox.com", "email1@spam.com"]
    mail.body.should =~ /Audi A4/
  end
end