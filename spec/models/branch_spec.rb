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
    salesperson_97 = @branch.salespeople.build(:email => "joergd@pobox.com", :job_title => "Salesperson")
    salesperson_98 = @branch.salespeople.build(:email => "karen@pobox.com", :job_title => "Salesperson")
    salesperson_99 = @branch.salespeople.build(:email => "manager@pobox.com", :job_title => "Parts Manager")
    
    @branch.salespeople_emails.should == ["joergd@pobox.com", "karen@pobox.com"]
  end
end
