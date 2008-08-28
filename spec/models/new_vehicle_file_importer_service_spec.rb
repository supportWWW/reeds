require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewVehicleFileImporterService do

  include ReedsSpecHelper
  
  before :all do
    @stock = read_file( 'reeds-stocksheet.csv' )
    @mm_list = read_file( 'sample-mmlist.csv' )
  end
  
    before :each do
      Classified.delete_all
      Model.delete_all
      Make.delete_all
    end
  
  def perform
    NewVehicleFileImporterService.instance.process( @stock )
  end
  
  describe 'performing imports' do
    
    it 'Should add 16 makes' do
      perform
      Make.count.should == 16
    end
    
    it 'Should add 165 classifieds' do
      perform
      Classified.count.should == 165
    end

    it 'Should add 88 models' do
      perform
      Model.count.should == 88
    end
    
  end
  
  describe 'trying to repeat an import' do
    
    def do_double_add
      perform
      perform
    end
    
    it 'Should add 16 makes' do
      do_double_add
      Make.count.should == 16
    end
    
    it 'Should add 165 classifieds' do
      do_double_add
      Classified.count.should == 165
    end

    it 'Should add 88 models' do
      do_double_add
      Model.count.should == 88
    end
    
  end
  
end