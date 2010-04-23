require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewVehicleFileImporterService do

  include ReedsSpecHelper
  
    before :all do
      @stock = read_file( 'opel-corsa.txt' )
      
      @make = mock_model(Make, :name => "Opel")
      @model_range = mock_model(ModelRange, :name => "Corsa", :make => @make)
      @model_range.stub!(:humanize)
      @new_vehicle = mock_model(NewVehicle, :id => 1, :year => 2008, :model_range => @model_range, :make => @make)
      
      @new_vehicle_variant = NewVehicleVariant.new(:new_vehicle => @new_vehicle)
      NewVehicle.stub!(:find).with(1).and_return(@new_vehicle)
      NewVehicleVariant.stub!(:find_or_initialize_by_new_vehicle_id_and_model_reference).and_return(@new_vehicle_variant)
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
      NewVehicleVariant.count.should == 1 # I think cos the stubs above
    end
    
  end
  
  describe 'trying to repeat an import' do
    
    def do_double_add
      perform
      perform
    end
    
    it 'Should add 9 new vehicle variants' do
      do_double_add
      NewVehicleVariant.count.should == 1
    end
    
  end
  
end