class PromotionBox < ActiveRecord::Base
  named_scope :active, :conditions => { :active => true }, :order => "position ASC"
  
  validates_presence_of :title, :body
  
  rendered_column :body

  STYLES = %w(service specials)
end
