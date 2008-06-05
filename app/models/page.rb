class Page < ActiveRecord::Base
  
  has_permalink :title, :title_permalink
  
  validates_presence_of :title, :text
  validates_uniqueness_of :title
  
  validates_uniqueness_of :title_permalink, :message => 'This title has already been taken', :if => :has_title?
  
  rendered_column :text
  
  def to_param
    title_permalink
  end
  
  def has_title?
    !title.blank?
  end
  
  class << self
    
    def find_with_permalink( *args )
      if args.size == 1 and args.first.kind_of?( String )
        find_without_permalink :first, :conditions => { :title_permalink => args.first }
      else
        find_without_permalink( *args )
      end
    end
  
    alias_method_chain :find, :permalink
    
  end  
  
end
