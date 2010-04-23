class Visit < ActiveRecord::Base
  belongs_to :referral, :counter_cache => true
  
  before_create :set_referer
  
  protected
  
  def set_referer
    if referer.blank?
      write_attribute_with_dirty(:referer, 'Direct')
    else
      temp = referer.gsub( 'http://', "" )
      if temp.include? '/'
        write_attribute_with_dirty( :referer_host , temp[ 0, temp.index( '/' ) ])
      else
        write_attribute_with_dirty( :referer_host , temp )
      end
    end
  end
  
end
