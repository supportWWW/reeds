module ModelsHelper

   def model_make_select(helper)
     helper.select(:make_id, Make.find(:all).collect{ |m| [m.common_name, m.id] }  )
   end

end
