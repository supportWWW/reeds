require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Page do
  before(:each) do
    @page = Page.new( :title =>'test', :text => 'text' )
  end

  it "should be valid" do
    @page.should be_valid
  end
  
  it 'Should not be valid without a title' do
    @page.title = nil
    @page.should have(1).error_on( :title )
  end

  it 'Should not be valid without a text' do
    @page.text = nil
    @page.should have(1).error_on( :text )
  end
  
end
