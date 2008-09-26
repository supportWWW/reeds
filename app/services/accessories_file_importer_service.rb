class AccessoriesFileImporterService
  
  include Singleton
  
  def process(new_vehicle_id, file_contents)
    added, error = [], []
    new_vehicle = NewVehicle.find(new_vehicle_id)
    FasterCSV.parse( file_contents, :col_sep => "\t" ) do |row|
      accessory = Accessory.new
      accessory.model_reference = row[1].strip
      accessory.new_vehicle_id = new_vehicle_id
      accessory.name = row[0].strip
      accessory.excl = strip_price(row[2])
      accessory.vat = strip_price(row[3])
      accessory.price = strip_price(row[4])
      if accessory.save
        added << accessory
      else
        error << accessory
      end
    end
    
    Accessory.delete_all(['id not in (?)', added.collect{ |i| i.id }])
    
    return added, error
  end
  
  def strip_price(value)
    if value
      value.strip.gsub(/ /, "").gsub(/,/, "").gsub(/R/, "").gsub(/r/, "")
    end
  end

end