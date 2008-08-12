module Admin::ModelVariantsHelper

   def model_variant_model_select(helper)
     helper.select(:model_id, Model.find(:all).collect{ |m| [m.name, m.id] }  )
   end
  
end
