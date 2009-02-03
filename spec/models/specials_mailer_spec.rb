require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SpecialsMailer do

  before(:each) do  
    ActionMailer::Base.delivery_method = :test  
    ActionMailer::Base.perform_deliveries = true  
    ActionMailer::Base.deliveries = []
  end

  it "should generate used email" do
    mail = SpecialsMailer.deliver_client_request(SpecialsForm.new(:first => "Joerg", :last => "Diek", :phone => "0214465543", :email => "me@spam.com", :special => "Isuzu"))
    ActionMailer::Base.deliveries.size.should == 1
    mail.to.should == ["rv@imaginet.co.za", "direct@reeds.co.za"]
    mail.body.should =~ /Isuzu/
  end
end