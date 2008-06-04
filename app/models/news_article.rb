class NewsArticle < ActiveRecord::Base
  has_permalink :title, :title_permalink
  
  validates_presence_of :title
  validates_uniqueness_of :title
  
  rendered_column :text
  
  belongs_to :category
  
  def source_url=( url )
    unless "http://" == url
      write_attribute_with_dirty( :source_url, url )
    end
  end
  
  def to_param
    title_permalink
  end
  
  class << self
    
    def paginate_current( page = 1 ) 
      paginate :page => page, :per_page => 10, :conditions => [ 'publish_at < ?', Time.now ], :order => 'publish_at desc'
    end
    
  end
  
end
