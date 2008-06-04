# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def partial( name, locals = {} )
    render :partial => name.to_s, :locals => locals
  end

end
