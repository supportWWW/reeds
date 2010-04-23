require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CyberstockFileImporterService do

  include ReedsSpecHelper
  
  before :all do
    @stock = read_file( 'cyberstock.csv' )
    @mm_list = read_file( 'sample-mmlist.csv' )
  end
  
    before :each do
      Classified.delete_all
      Model.delete_all
      Make.delete_all
    end
  
  def perform
    CyberstockFileImporterService.instance.process( @stock )
  end
  
  describe 'performing imports' do
    
    it 'Should add 4 makes' do
      perform
      Make.count.should == 4
    end
    
    it 'Should add 29 classifieds' do
      perform
      Cyberstock.count.should == 29
    end

    it 'Should add 20 models' do
      perform
      Model.count.should == 20
    end
    
  end
  
  describe 'trying to repeat an import' do
    
    def do_double_add
      perform
      perform
    end
    
    it 'Should add 4 makes' do
      do_double_add
      Make.count.should == 4
    end
    
    it 'Should add 29 classifieds' do
      do_double_add
      Cyberstock.count.should == 29
    end

    it 'Should add 20 models' do
      do_double_add
      Model.count.should == 20
    end
    
  end
  
end