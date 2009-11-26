class StockFileImporterService
  
  include Singleton
  
  def process( file_contents )
    added, error = [], []
    line = 0
    FasterCSV.parse( file_contents, :col_sep => "\t", :headers => true ) do |row|
      line += 1
      begin
        model_variant = ModelVariant.find_or_create_for( row[2], row[3] , row[6], row[4] )
        classified = Classified.find_or_initialize_by_stock_code( row[0].strip )
        classified[:type] = "UsedVehicle"
        classified.model_variant_id = model_variant.id

      
        branch = Branch.find_by_stock_code_prefix(row[0].first)
        classified.branch = branch
      
        classified.year = row[4].strip unless row[4].nil? # denormalization for search
        classified.price= row[5].strip.gsub(/ /, "") unless row[5].nil?
        classified.colour = row[7].strip unless row[7].nil?
        classified.reg_num = row[8].strip unless row[8].nil?
        classified.mileage = row[9].strip.gsub(/ /, "") unless row[9].nil?
        classified.features = row[10].strip unless row[10].nil?
        classified.days_in_stock = row[13].strip unless row[13].nil?
        classified.removed_at = nil

        if classified.save
          added << classified
        end
      rescue
        error << classified
      end
    end
    
    UsedVehicle.update_all( { :removed_at => Time.now }, [ 'id not in ( ? ) and removed_at is null', added.collect{ |i| i.id } ] )
    
    return added, error
  end
  
  def strip_value( value )
    if value
      value.strip
    end
  end
  
end