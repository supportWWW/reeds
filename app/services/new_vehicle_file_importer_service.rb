class NewVehicleFileImporterService
  
  include Singleton
  
  def process(new_vehicle_id, file_contents)
    added, error = [], []
    new_vehicle = NewVehicle.find(new_vehicle_id)
    FasterCSV.parse( file_contents, :col_sep => "\t" ) do |row|
      new_vehicle_variant = NewVehicleVariant.find_or_initialize_by_model_reference( row[1].strip )
      new_vehicle_variant.new_vehicle_id = new_vehicle_id
      new_vehicle_variant.name = strip_variant(new_vehicle, row[0])
      new_vehicle_variant.excl = strip_price(row[2])
      new_vehicle_variant.vat = strip_price(row[3])
      new_vehicle_variant.price = strip_price(row[4])
      if new_vehicle_variant.save
        added << new_vehicle_variant
      else
        error << new_vehicle_variant
      end
    end
    
    NewVehicleVariant.delete_all(['id not in (?)', added.collect{ |i| i.id }])
    
    return added, error
  end
  
  def strip_price(value)
    if value
      value.strip.gsub(/ /, "").gsub(/,/, "").gsub(/R/, "").gsub(/r/, "")
    end
  end

  def strip_variant(new_vehicle, value)
    if value
      value.gsub(new_vehicle.make.name.upcase, "").gsub(new_vehicle.model_range.name.upcase, "").strip
    end
  end
  
end