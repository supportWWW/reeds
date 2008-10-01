#---
# Excerpted from "Advanced Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_arr for more book information.
#---
class HealthCheckHandler < Mongrel::HttpHandler
  
  def initialize
    @db_ok_at  = Time.at(0)
    @freshness = 30 
    @error     = ''
  end
  
  def process(request,response)
    check_db if db_stale?
    
    if ActiveRecord::Base.connected?
      code = db_stale? ? 500 : 200
    else
      code = 200
    end
    
    response.start(code) do |head,out|
      head["Content-Type"] = "text/html"
      
      t = Time.now
      out.write "Now: #{t}, DB OK #{t - @db_ok_at}s ago\n"
      out.write "ERROR: #{@error}" if @error != ""
    end
  end
  
  def db_stale?
    (Time.now - @db_ok_at).to_i > @freshness
  end
  
  def check_db
    if ActiveRecord::Base.connected?
      begin   
        ActiveRecord::Base.connection.verify!(0)
        ActiveRecord::Base.connection.select_value("SELECT NOW()")
        @db_ok_at = Time.now
        @error = ''
      rescue Exception => e
        # Do your logging/error handling here
        @error = e.inspect
      end
    end 
  end
end

uri "/health-check", :handler => HealthCheckHandler.new, 
                     :in_front => true