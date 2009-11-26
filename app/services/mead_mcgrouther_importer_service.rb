class MeadMcgroutherImporterService
  include Singleton
=begin
          $make = trim($values[0]);
          $code = trim($values[2]);
	  $model = htmlentities($values[3], ENT_QUOTES);
	  $year = trim($values[4]);
=end
  
  def process( file_contents )
    result = []
    error = []
    model_variant = nil
    begin
  #    file_contents.each_line do |line|
  #      row = line.gsub( '"', '' ).split( ',' )
  #      p "Line #{line.gsub( '"', '' )}"
        #result << ModelVariant.find_or_create_for( row[0].strip , row[3].strip, row[2].strip, row[4].strip)
  #   end
      FasterCSV.parse( file_contents ) do |row|
        model_variant = ModelVariant.find_or_create_for( row[0].strip , row[3].strip, row[2].strip, row[4].strip)
        result << model_variant
      end
    rescue
      error << model_variant
    end
    return result, error
  end
  
end