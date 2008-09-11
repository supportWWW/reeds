require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AccessoriesFileImporterService do

  include ReedsSpecHelper
  
    before :all do
      @stock = read_file( 'opel-corsa-accessories.txt' )
      
      @make = mock_model(Make, :name => "Opel")
      @model_range = mock_model(ModelRange, :name => "Corsa", :make => @make)
      @new_vehicle = mock_model(NewVehicle, :id => 1, :year => 2008, :model_range => @model_range, :make => @make)
      
      NewVehicle.stub!(:find).with(1).and_return(@new_vehicle)
    end
  
    before :each do
      Accessory.delete_all
    end
  
  def perform
    AccessoriesFileImporterService.instance.process(@new_vehicle.id, @stock)
  end
  
  describe 'performing imports' do
    
    it 'Should add 2 accessories' do
      perform
      Accessory.count.should == 2
    end
    
  end
  
  describe 'trying to repeat an import' do
    
    def do_double_add
      perform
      perform
    end
    
    it 'Should add 2 accessories' do
      do_double_add
      Accessory.count.should == 2
    end
    
  end
  
end