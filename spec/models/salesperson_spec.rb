require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Salesperson do
  before(:each) do
    @salesperson = Salesperson.new( :name => 'test', :phone => '888888', :email => 'mauricio@gmail.com', :job_title => "Salesperson" )
  end

  it "should be valid" do
    @salesperson.should be_valid
  end
  
  
end
