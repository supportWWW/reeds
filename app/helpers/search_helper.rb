module SearchHelper
  def makes_for_select(type="classified")
    makes = type == "classified" ? Make.find_in_stock.collect { |m| [m.name, m.id] } : Make.new_vehicles.collect { |m| [m.name, m.id] }
    makes.insert(0, [ 'Any make', '' ])
  end
  
  def makes_options(type="classified", selected=nil)
    selected = nil if selected && selected.to_i == 0
    unless selected.nil?
      if selected.class != Make
        selected = Make.find(selected.to_i)
      end
    end
    options_for_select(makes_for_select(type), selected.nil? ? nil : [selected.name, selected.id])
  end

  def models_for_select(make=nil)
    models = make.nil? ? [] : make.find_models_in_stock.collect { |m| [m.name, m.id] }
    models.insert(0, [ 'Any model', '' ])
  end

  def models_options(make_id=nil, selected=nil)
    selected = nil if selected && selected.to_i == 0
    make_id = nil if make_id && make_id.to_i == 0
    unless selected.nil?
      if selected.class != Model
        selected = Model.find(selected.to_i)
      end
    end
    make = make_id.nil? ? nil : Make.find(make_id.to_i)
    options_for_select(models_for_select(make), selected.nil? ? nil : [selected.name, selected.id])
  end

  def model_ranges_for_select(make=nil)
    model_ranges = make.nil? ? [] : make.model_ranges.find(:all, :order => 'name').collect { |m| [m.name, m.id] }
    model_ranges.insert(0, [ 'Any series', '' ])
  end

  def model_ranges_options(make_id=nil, selected=nil)
    selected = nil if selected && selected.to_i == 0
    make_id = nil if make_id && make_id.to_i == 0
    unless selected.nil?
      if selected.class != ModelRange
        selected = ModelRange.find_by_id(selected.to_i)
      end
    end
    make = make_id.nil? ? nil : Make.find(make_id.to_i)
    options_for_select(model_ranges_for_select(make), selected.nil? ? nil : [selected.name, selected.id])
  end

  def years_for_select
    years = (1960..(Date.today.year)).to_a.reverse.collect { |y| [y, y] }
    years.insert(0, ['Any', ''])
  end
  
  def year_options(selected=nil)
    options_for_select(years_for_select, selected.nil? ? nil : selected.to_i)
  end
  
end
