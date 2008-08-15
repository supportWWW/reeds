# Methods added to this helper will be available to all templates in the
# application.
module ApplicationHelper

  def partial( name, locals = {} )
    render :partial => name.to_s, :locals => locals
  end

  def link_for_menu( menu_item )
    if menu_item.path.blank?
      link_to menu_item.title, menu_item.page
    else
      link_to menu_item.title, menu_item.path
    end
  end
  
  def spinner( id = 'spinner' )
    "<span id='#{id}' style='display:none;'>#{image_tag "spinner.gif"}</span>"
  end
  
  def boolean_label( value )
    value ? 'Yes' : 'No'
  end
  
  def table_with_block( *headers, &block )
    table_top = %Q{
  <table>
    <thead>
      <tr>\n}
    
    table_top << headers.collect{ |i| "<th>#{i}</th>" }.join( "\n" )
    table_top << "\n</tr>\n</thead>\n<tbody>\n"
    
    content = capture(&block)
    concat( table_top , block.binding)
    concat(content, block.binding)
    concat("\n</tbody>\n</table>", block.binding)
  end
  
  def makes_for_select
    makes = Make.find(:all, :order => 'name').collect { |m| [m.name, m.id] }
    makes.insert(0, [ 'Select a make...', '' ])
  end
  
  def makes_options(selected=nil)
    options_for_select(makes_for_select, selected.nil? ? nil : [selected.name, selected.id])
  end
  
end
