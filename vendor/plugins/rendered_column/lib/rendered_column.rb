
module RenderedColumn

  def self.included(klass)
    klass.extend(ClassMethods)
  end
  
  def self.render_text( text, format, use_erb, options )
    return "" if text.nil? or text.blank?
    text = ERB.new(text).result if use_erb
    case format
    when 'textile'
      RedCloth.new(text, options).to_html
    when 'markdown'
      BlueCloth.new(text, options).to_html
    when 'smartypants'
      RubyPants.new(text).to_html
    else
      raise "#{format} format is not available"
    end
  end
  
  # Calls required on the various types... It will through a LoadError if 
  # a format is referenced but not available.
  def self.ensure_format(format)
    case format
    when 'textile'
      require 'redcloth'
    when 'markdown'
      require 'bluecloth'
    when 'smartypants'
      require 'rubypants'
    else
      raise "#{format} format is not available"
    end
  end

  module ClassMethods
    
    def rendered_column( field, options={} )
      options = {
        :postfix=>'',
        :prefix=>'rendered_',
        :format=>'textile',
        :use_erb=>false,
        :options=>{}
      }.merge(options)
      RenderedColumn.ensure_format options[:format]
      before_save do |record|
        rendered_field_name = "#{options[:prefix]}#{field.to_s}#{options[:postfix]}"
        record[rendered_field_name] = RenderedColumn.render_text( record[field], options[:format], options[:use_erb], options[:options] )
      end
    end
    
  end
  
end