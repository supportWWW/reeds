class CyberstockFileImporterService
  
  include Singleton
  
  def process( file_contents )
    added, error = [], []
    FasterCSV.parse( file_contents, :col_sep => "\t" ) do |row|
      model_variant = ModelVariant.find_or_create_for( row[2], row[3] , row[6], row[4] )
      classified = Classified.find_or_initialize_by_stock_code( row[0].strip )
      classified[:type] = "Cyberstock"
      classified.model_variant_id = model_variant.id
      classified.year = row[4].strip # denormalization for search
      classified.price= row[5].strip
      classified.colour = row[7].strip
      classified.reg_num = row[8].strip
      classified.mileage = row[9].strip
      classified.features = row[10].strip
      classified.img_url = row[11].strip
      classified.days_in_stock = row[13].strip
      classified.removed_at = nil
      if classified.save
        added << classified
      else
        error << classified
      end
    end
    
    Classified.update_all( { :removed_at => Time.now }, [ 'id not in ( ? ) and removed_at is null', added.collect{ |i| i.id } ] )
    
    return added, error
  end
  
  def strip_value( value )
    if value
      value.strip
    end
  end
  
end