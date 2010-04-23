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
    line = 0
#    file_contents.each_line do |line|
#      row = line.gsub( '"', '' ).split( ',' )
#      p "Line #{line.gsub( '"', '' )}"
      #result << ModelVariant.find_or_create_for( row[0].strip , row[3].strip, row[2].strip, row[4].strip)
#   end
    FasterCSV.parse( file_contents ) do |row|
      begin
        line += 1
        result << ModelVariant.find_or_create_for( row[0].strip , row[3].strip, row[2].strip, row[4].strip)
      rescue
        error << line
      end
    end
    return result, error
  end
  
end