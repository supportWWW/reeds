require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe VehicleEnquiryMailer do

  before(:each) do  
    ActionMailer::Base.delivery_method = :test  
    ActionMailer::Base.perform_deliveries = true  
    ActionMailer::Base.deliveries = []
    
    @branch = Branch.create!( :name => 'test' )
    @salesperson = Salesperson.create!( :name => 'test', :phone => '888888', :email => 'mauricio@gmail.com', :job_title => "Salesperson", :receive_web_leads => true )
    @assignment = Assignment.create!( :branch => @branch, :salesperson => @salesperson )
    
  end

  it "should generate used email" do
    mail = VehicleEnquiryMailer.deliver_used(UsedVehicleEnquiryForm.new(:first => "Joerg", :last => "Diek", :phone => "0214465543", :email => "me@spam.com", :vehicle => "Isuzu", :branch_id => @branch.id))
    ActionMailer::Base.deliveries.size.should == 1
    mail.to.should == ["direct@reeds.co.za"] # ["mauricio@gmail.com"]
    mail.body.should =~ /Isuzu/
  end

  it "should generate neww email" do
    mail = VehicleEnquiryMailer.deliver_neww(NewVehicleEnquiryForm.new(:first => "Joerg", :last => "Diek", :phone => "0214465543", :email => "me@spam.com", :vehicle => "Isuzu"))
    ActionMailer::Base.deliveries.size.should == 1
    mail.to.should == ["direct@reeds.co.za"]
    mail.body.should =~ /Isuzu/
  end
end