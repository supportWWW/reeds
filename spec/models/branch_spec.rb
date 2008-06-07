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
  
end
