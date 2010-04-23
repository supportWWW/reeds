class NewsArticle < ActiveRecord::Base
  
  include ImageHelper
  
  has_permalink :title, :title_permalink
  
  validates_presence_of :title, :text
  validates_uniqueness_of :title
  
  validates_uniqueness_of :title_permalink, :message => 'This title has already been taken', :if => :has_title?
  
  rendered_column :text
  
  belongs_to :category
  
  named_scope :live, :order => "publish_at desc"
  
  before_create :set_publish_at
  
  def source_url=( url )
    unless "http://" == url
      write_attribute_with_dirty( :source_url, url )
    end
  end
  
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
    
    def paginate_current( page = 1 ) 
      paginate :page => page, :per_page => 10, :conditions => [ 'publish_at < ?', Time.now ], :order => 'publish_at desc'
    end
  
    alias_method_chain :find, :permalink
    
  end
  
  
private

  def set_publish_at
    self[:publish_at] = Date.today
  end
end
