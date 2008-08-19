module SearchHelper
  def makes_for_select
    makes = Make.find(:all, :order => 'name').collect { |m| [m.name, m.id] }
    makes.insert(0, [ 'Any make', '' ])
  end
  
  def makes_options(selected=nil)
    unless selected.nil?
      if selected.class != Make
        selected = Make.find(selected.to_i)
      end
    end
    options_for_select(makes_for_select, selected.nil? ? nil : [selected.name, selected.id])
  end

  def models_for_select
    models = Model.find(:all, :order => 'name').collect { |m| [m.name, m.id] }
    models.insert(0, [ 'Any model', '' ])
  end

  def models_options(selected=nil)
    unless selected.nil?
      if selected.class != Model
        selected = Model.find(selected.to_i)
      end
    end
    options_for_select(models_for_select, selected.nil? ? nil : [selected.name, selected.id])
  end

  def years_for_select
    years = (1960..(Date.today.year)).to_a.collect { |y| [y, y] }
    years.insert(0, ['Any', ''])
  end
  
  def year_options(selected=nil)
    options_for_select(years_for_select, selected.nil? ? nil : selected.to_i)
  end
  
end
