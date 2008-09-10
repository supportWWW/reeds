require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe G2ExporterService do

  include ReedsSpecHelper
  
  before :all do
    @stock = read_file( 'reeds-stocksheet.csv' )
  end

  before :each do
    Classified.delete_all
    Model.delete_all
    Make.delete_all
    StockFileImporterService.instance.process( @stock )
  end
  
  describe 'perform export' do
    
    csv = G2ExporterService.instance.process()

    it 'Should export 165 cars' do
      csv.size == 165
    end
    
  end
    
end