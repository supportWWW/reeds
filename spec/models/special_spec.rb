require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Special do
  before(:each) do
    @special = Special.new( :title =>'test', :text => 'text' )
  end

  it "should be valid" do
    @special.should be_valid
  end
  
  it 'Should not be valid without a title' do
    @special.title = nil
    @special.should have(1).error_on( :title )
  end

  it 'Should not be valid without a text' do
    @special.text = nil
    @special.should have(1).error_on( :text )
  end
  
end
