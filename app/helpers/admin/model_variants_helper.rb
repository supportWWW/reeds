module Admin::ModelVariantsHelper

   def model_variant_model_select(helper)
     helper.select(:model_id, Model.find(:all).collect{ |m| [m.name, m.id] }  )
   end

   def model_variant_select(helper, model)
     helper.select(:model_variant_id, ModelVariant.find(:all, :conditions => { :model_id => model.id }).collect{ |m| [m.year, m.id] }  )
   end

  
end
