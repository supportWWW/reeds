require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BookTestDriveMailer do

  before(:each) do  
    ActionMailer::Base.delivery_method = :test  
    ActionMailer::Base.perform_deliveries = true  
    ActionMailer::Base.deliveries = []
  end

  it "should generate neww email" do
    mail = BookTestDriveMailer.deliver_neww(BookTestDriveForm.new(:first => "Joerg", :last => "Diek", :phone => "0214465543", :email => "me@spam.com", :vehicle => "Isuzu", :branch => "CPT"))
    ActionMailer::Base.deliveries.size.should == 1
    mail.to.should == ["direct@reeds.co.za"]
    mail.body.should =~ /Isuzu/
  end
end