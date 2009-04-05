require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StockListMailer do

  before(:each) do  
    ActionMailer::Base.delivery_method = :test  
    ActionMailer::Base.perform_deliveries = true  
    ActionMailer::Base.deliveries = []  

    @classified = mock_model(Classified)
    @classified.stub!(:stock_code).and_return("MyString")
    @classified.stub!(:humanize).and_return("MyString")
    @classified.stub!(:year).and_return("1973")
    @classified.stub!(:price).and_return(Money.new(1))
    @classified.stub!(:price_in_cents).and_return(1)
    @classified.stub!(:mileage).and_return("1")
    @classified.stub!(:colour).and_return("Blue")
  end

  it "should generate email" do
    mail = StockListMailer.deliver_list("Joerg", "email1@spam.com", [@classified])
    ActionMailer::Base.deliveries.size.should == 1
    mail.to.should == ["email1@spam.com"]
    mail.body.should =~ /1973/
  end
end