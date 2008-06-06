require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Referral do
  before(:each) do
    @referral = Referral.new( :name => 'Test', :redirect_to => '/' )
  end

  it "should be valid" do
    @referral.should be_valid
  end
  
  it 'Should not be valid without a name' do
    @referral.name = nil
    @referral.should have(1).error_on( :name )
  end
  
  it 'Should not be valid without a redirect_to' do
    @referral.redirect_to = nil
    @referral.should have(1).error_on( :redirect_to )    
  end
  
end
