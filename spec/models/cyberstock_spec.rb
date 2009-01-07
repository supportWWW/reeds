require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Cyberstock do
  before(:each) do
    @cyberstock = Cyberstock.new
    @cyberstock.stub!(:humanize).and_return("Audi A4")
    @cyberstock.stub!(:year).and_return("2008")
    @cyberstock.stub!(:mileage).and_return(16000)
    @cyberstock.stub!(:price).and_return(Money.new(25000000))
    @cyberstock.stub!(:expires_on).and_return(Date.today)
    @cyberstock.stub!(:stock_code).and_return("123")
    @cyberstock.stub!(:physical_stock).and_return("phy555")
    @cyberstock.stub!(:colour).and_return("red")

    @cyberstock.branch = Branch.new
    @cyberstock.branch.stub!(:salespeople_emails).and_return(["joergd@pobox.com"])
  end

  it "should be Cyberstock" do
    @cyberstock.class.should == Cyberstock
  end
  
  it "should send email for all (in this case 1) expired cyberstock" do
    Cyberstock.stub!(:find).and_return([@cyberstock])
    Cyberstock.expiry_check.should == true
  end
end
