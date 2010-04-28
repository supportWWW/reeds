require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Branch do
  before(:each) do
    @branch = Branch.new( :name => 'test' )
  end

  it "should be valid" do
    @branch.should be_valid
  end
  
  it 'Should not be valid without a name' do
    should_have_errors( @branch, :name )
  end

  it "Should return some emails" do
    salesperson_97 = @branch.salespeople.build(:email => "support@whitewallweb.com", :job_title => "Salesperson")
    salesperson_98 = @branch.salespeople.build(:email => "francois@cpt.whitewallweb.com", :job_title => "Salesperson")
    salesperson_99 = @branch.salespeople.build(:email => "nic@cpt.whitewallweb.com", :job_title => "Parts Manager")
    
    @branch.salespeople_emails.should == ["support@whitewallweb.com", "francois@cpt.whitewallweb.com"]
  end
end
