require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MenuItem do
  before(:each) do
    @menu_item = MenuItem.new( :title => 'Test', :position => 0, :path => '/path' )
  end

  it "should be valid" do
    @menu_item.should be_valid
  end
end
