require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewVehicleFileImporterService do

  include ReedsSpecHelper
  
    before :all do
      @stock = read_file( 'opel-corsa.txt' )
      
      @make = mock_model(Make, :name => "Opel")
      @model_range = mock_model(ModelRange, :name => "Corsa", :make => @make)
      @new_vehicle = mock_model(NewVehicle, :id => 1, :year => 2008, :model_range => @model_range, :make => @make)
      
      NewVehicle.stub!(:find).with(1).and_return(@new_vehicle)
    end
  
    before :each do
      NewVehicleVariant.delete_all
    end
  
  def perform
    NewVehicleFileImporterService.instance.process(@new_vehicle.id, @stock)
  end
  
  describe 'performing imports' do
    
    it 'Should add 9 new vehicle variants' do
      perform
      NewVehicleVariant.count.should == 9
    end
    
  end
  
  describe 'trying to repeat an import' do
    
    def do_double_add
      perform
      perform
    end
    
    it 'Should add 9 new vehicle variants' do
      do_double_add
      NewVehicleVariant.count.should == 9
    end
    
  end
  
end