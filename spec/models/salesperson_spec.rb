require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Salesperson do
  before(:each) do
    @salesperson = Salesperson.new( :name => 'test', :phone => '888888', :email => 'mauricio@gmail.com', :job_title => "Salesperson" )
  end

  it "should be valid" do
    @salesperson.should be_valid
  end
  
  it 'Should have an error on name if no name is provided' do
    should_have_errors @salesperson, :name
  end

  it 'Should have an error on phone if no phone is provided' do
    should_have_errors @salesperson, :phone
  end
  
  it 'Should have an error on email if no email is provided' do
    should_have_errors @salesperson, :email
  end  
  
  
end
