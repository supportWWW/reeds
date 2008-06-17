require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MeadMcgroutherImporterService do

  include ReedsSpecHelper
  
  before :all do
    @stock = read_file( 'reeds-stocksheet.csv' )
    @mm_list = read_file( 'sample-mmlist.csv' )
  end
  
  before :each do
    ModelVariant.delete_all
    Model.delete_all
    Make.delete_all
  end
  
  def perform
    @result = MeadMcgroutherImporterService.instance.process( @mm_list )
  end
  
  describe 'importing a mead mcgrouther listing' do
    
    it 'Should have 218 makes, 11044 models and 42237 model variants' do
      raise 'This spec takes A LOT of time to run (on Mauricio\'s pc, usually 170 seconds) so uncomment this only if you REALLY need to run it'
      perform
      Make.count.should == 218
      Model.count.should == 11120
      ModelVariant.count.should == 42237
    end
    
  end
  
end 
