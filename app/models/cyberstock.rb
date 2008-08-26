class Cyberstock < Classified

  has_permalink [:humanize, :stock_code]

  belongs_to :branch
  
  named_scope :live, lambda { { :conditions => ["removed_at is NULL AND expires_on > ?", Date.today] } }
  named_scope :expired, lambda { { :conditions => ["removed_at is NULL AND expires_on <= ?", Date.today] } }

  class << self
    
    def find_with_permalink( *args )
      if args.size == 1 and !args.first.kind_of?(Symbol) and args.first.to_i.to_s != args.first.to_s
        find_without_permalink :first, :conditions => { :permalink => args.first }
      else
        find_without_permalink( *args )
      end
    end
    
    alias_method_chain :find, :permalink
    
  end

end