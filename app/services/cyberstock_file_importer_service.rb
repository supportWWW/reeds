class CyberstockFileImporterService
  
  include Singleton
  
  def process( file_contents )
    added, error = [], []
    FasterCSV.parse( file_contents, :col_sep => ",", :headers => true ) do |row|
      if !row[3].blank? && !row[4].blank? && !row[14].blank? && !row[5].blank?
        model_variant = ModelVariant.find_or_create_for( row[3], row[4] , row[14], row[5] )
        branch = Branch.find_by_cyberstock_prefix(row[2])
        classified = Cyberstock.find_or_initialize_by_stock_code( row[1].strip )
        #classified[:type] = "Cyberstock"
        classified.model_variant_id = model_variant.id
        classified.physical_stock = row[12] || row[13] # only one of these will be set.
        classified.branch = branch
        classified.year = row[5].strip # denormalization for search
        classified.price= row[8].strip.gsub(/ /, "") unless row[8].nil?
        classified.colour = row[6].strip unless row[6].nil?
        classified.mileage = row[7].strip.gsub(/ /, "") unless row[7].nil?
        classified.features = row[10].strip unless row[10].nil?
        classified.has_service_history = row[9].strip.downcase == "yes" unless row[9].nil?
        classified.expires_on = get_date(row[0].strip) unless row[0].nil?
        classified.removed_at = nil
        if classified.save
          added << classified
        else
          error << classified
        end
      end
    end
    
    #Cyberstock.update_all( { :removed_at => Time.now }, [ 'id not in ( ? ) and removed_at is null', added.collect{ |i| i.id } ] )
    
    return added, error
  end
  
  def strip_value( value )
    if value
      value.strip
    end
  end
  
  def get_date(s)
    return nil if s.blank?
    components = s.split("/").map(&:to_i)
    Date.new(components[2], components[1], components[0])
  end
end