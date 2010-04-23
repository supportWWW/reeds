require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Category do
  before(:each) do
    @category = Category.new( :name => 'test' )
  end

  after :each do
    Category.delete_all
  end
  
  it "should be valid" do
    @category.should be_valid
  end
  
  it 'Should validate the presence of a name' do
    @category.name = nil
    @category.should have(1).error_on( :name )
  end

  it 'Should validate the uniqueness of a name' do
    @category.save!
    @other_category = Category.new
    @other_category.name = @category.name
    @other_category.should have(1).error_on( :name )
  end
  
end
