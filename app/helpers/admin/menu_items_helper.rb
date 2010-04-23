module Admin::MenuItemsHelper
  
  def pages_select( form_helper )
    pages = [ [ '...', '' ] ]
    pages.push( *Page.find( :all ).collect{ |p| [p.title, p.id] } )
    if pages.size == 1
      '<p>There are no pages available on the cms yet</p>'
    else
      form_helper.select :page_id, pages
    end
  end
  
  def parents_select( form_helper )
    items = [ [ '...', '' ] ]
    unless @menu_item.new_record?
      items.push( *MenuItem.find( :all, :conditions => [ 'id != ?', @menu_item.id ] ).collect{ |p| [p.title_with_depth, p.id] } )  
    else
      items.push( *MenuItem.find( :all ).collect{ |p| [p.title_with_depth, p.id] } )  
    end
    
    if items.size == 1
       "<p>There are no other menu items available yet</p>"
    else
      form_helper.select :parent_id, items
    end
  end
  
  
end
