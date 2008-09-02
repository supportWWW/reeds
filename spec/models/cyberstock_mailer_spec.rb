require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CyberstockMailer do

  before(:each) do  
    ActionMailer::Base.delivery_method = :test  
    ActionMailer::Base.perform_deliveries = true  
    ActionMailer::Base.deliveries = []  
  end

  it "should generate email" do
    @cyberstock = mock_model(Cyberstock)
    @cyberstock.stub!(:humanize).and_return("Audi A4")
    @cyberstock.stub!(:year).and_return("2008")
    @cyberstock.stub!(:mileage).and_return(16000)
    @cyberstock.stub!(:price).and_return(Money.new(25000000))
    @cyberstock.stub!(:expires_on).and_return(Date.today)
    @cyberstock.stub!(:stock_code).and_return("123")
    @cyberstock.stub!(:physical_stock).and_return("phy555")
    @cyberstock.stub!(:colour).and_return("red")
    
    mail = CyberstockMailer.deliver_soon_to_expire(["email1@spam.com", "email2@spam.com"], @cyberstock)
    ActionMailer::Base.deliveries.size.should == 1
    mail.to.should == ["joergd@pobox.com", "email1@spam.com", "email2@spam.com"]
    mail.body.should =~ /Audi A4/
  end
end