module Admin::MakesHelper

  def makes_for_select
    makes = Make.find( :all, :order => 'name' ).collect { |m| [ m.name, m.id ] }
    makes.insert( 0, [ 'Select a make...', '' ] )
  end
  
  def makes_options
    options_for_select( makes_for_select )
  end
  
end
