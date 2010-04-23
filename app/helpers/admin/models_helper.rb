module Admin::ModelsHelper

   def model_make_select(helper)
     helper.select(:make_id, Make.find(:all).collect{ |m| [m.common_name, m.id] }  )
   end

   def models_for_select
     models = Model.find(:all, :order => 'name').collect { |m| [m.name, m.id] }
     models.insert(0, [ 'Select a make first...', '' ])
   end

   def models_options(selected=nil)
     options_for_select(models_for_select, selected.nil? ? nil : [selected.name, selected.id])
   end


end
