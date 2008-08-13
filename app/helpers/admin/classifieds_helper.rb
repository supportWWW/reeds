module Admin::ClassifiedsHelper

  def model_variant_select(helper, model)
    helper.select(:model_variant_id, ModelVariant.find(:all, :conditions => { :model_id => model.id }).collect{ |m| [m.year, m.id] }  )
  end

  def makes_for_select
    makes = Make.find(:all, :order => 'name').collect { |m| [m.name, m.id] }
    makes.insert(0, [ 'Select a make...', '' ])
  end
  
  def makes_options(selected=nil)
    options_for_select(makes_for_select, selected.nil? ? nil : [selected.name, selected.id])
  end

  def models_for_select
    models = Model.find(:all, :order => 'name').collect { |m| [m.name, m.id] }
    models.insert(0, [ 'Select a make first...', '' ])
  end

  def models_options(selected=nil)
    options_for_select(models_for_select, selected.nil? ? nil : [selected.name, selected.id])
  end

end
