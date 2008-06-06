class Visit < ActiveRecord::Base
  belongs_to :referral, :counter_cache => true
  
  before_save :set_referer
  
  protected
  
  def set_referer
    if referer.blank?
      write_attribute_with_dirty(:referer, 'No referer')
    end
  end
  
end
