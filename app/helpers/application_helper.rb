# Methods added to this helper will be available to all templates in the application.
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
  
end
