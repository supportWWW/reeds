module ContactHelper
  def sell_makes_for_select
    makes = Make.collect { |m| [m.name, m.id] }
    makes.insert(0, [ 'Any make', '' ])
  end
  
  def sell_makes_options(selected=nil)
    selected = nil if selected && selected.to_i == 0
    unless selected.nil?
      if selected.class != Make
        selected = Make.find(selected.to_i)
      end
    end
    options_for_select(makes_for_select, selected.nil? ? nil : [selected.name, selected.id])
  end

  def sell_model_ranges_for_select(make=nil)
    model_ranges = make.nil? ? [] : make.model_ranges.collect { |m| [m.name, m.id] }
    model_ranges.insert(0, [ 'Any series', '' ])
  end

  def sell_model_ranges_options(make_id=nil, selected=nil)
    selected = nil if selected && selected.to_i == 0
    make_id = nil if make_id && make_id.to_i == 0
    unless selected.nil?
      if selected.class != ModelRange
        selected = ModelRange.find_by_id(selected.to_i)
      end
    end
    make = make_id.nil? ? nil : Make.find(make_id.to_i)
    options_for_select(sell_model_ranges_for_select(make), selected.nil? ? nil : [selected.name, selected.id])
  end

end
