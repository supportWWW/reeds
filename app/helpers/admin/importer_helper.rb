module Admin::ImporterHelper

  def new_vehicle_options(selected=nil)
    selected = nil if selected && selected.to_i == 0
    unless selected.nil?
      if selected.class != NewVehicle
        selected = NewVehicle.find(selected.to_i)
      end
    end
    options_for_select(NewVehicle.for_select, selected.nil? ? nil : [selected.name, selected.id])
  end

end
