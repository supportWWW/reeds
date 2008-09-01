module Admin::ImporterHelper

  def model_ranges_options(selected=nil)
    selected = nil if selected && selected.to_i == 0
    unless selected.nil?
      if selected.class != ModelRange
        selected = ModelRange.find(selected.to_i)
      end
    end
    options_for_select(ModelRange.for_select, selected.nil? ? nil : [selected.name, selected.id])
  end

end
