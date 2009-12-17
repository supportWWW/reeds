# Methods added to this helper will be available to all templates in the
# application.
module ApplicationHelper

  def partial( name, locals = {} )
    render :partial => name.to_s, :locals => locals
  end

  def url_for_menu( menu_item )
    if menu_item.path.blank?
      page_path(menu_item.page)
    else
      menu_item.path
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

  def link_to_section(name, html_opts={}, &block)
    section_id = name.underscore.gsub(/\s+/,'_')
    link_id = section_id + '_link'
    # Link
    concat(link_to_function(name, "$('##{section_id}').show(); $('##{link_id}').hide();return false;",
        html_opts.update(:id => link_id)), block.binding)
    # Hidden section
    concat(tag('div', { :id => section_id, :style => 'display: none;' }, true), block.binding)
    yield "$('##{section_id}').hide(); $('##{link_id}').show();return false;"
    concat('</div>', block.binding)
  end

  # from Dan Webb's MinusMOR plugin
  # enhanced with ability to detect partials with template format, i.e.: _post.html.erb
  def js_partial(name, options={})
    old_format = self.template_format
    self.template_format = :html
    js render({ :partial => name }.merge(options))
  ensure
    self.template_format = old_format
  end  

  # from Dan Webb's MinusMOR plugin
  def js(data)
    if data.respond_to? :to_json
      data.to_json
    else
      data.inspect.to_json
    end
  end

end
