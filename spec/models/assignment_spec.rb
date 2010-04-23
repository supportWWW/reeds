require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Assignment do
  before(:each) do
    @assignment = Assignment.new( :branch_id => 1, :salesperson_id => 1 )
  end

  after :each do
    Assignment.delete_all
  end
  
  it "should be valid" do
    @assignment.should be_valid
  end
  
  it 'Should not let the same salesperson be assigned twice to the same branch' do
    @assignment.save!
    @other_assignment = Assignment.new( @assignment.attributes )
    @other_assignment.should have(1).error_on( :salesperson_id )
  end
  
end
