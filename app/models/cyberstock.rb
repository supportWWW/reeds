class Cyberstock < Classified

  validates_presence_of :branch_id
  
  has_permalink [:humanize, :stock_code]

  belongs_to :branch
  
  named_scope :live, lambda { { :conditions => ["removed_at is NULL AND expires_on > ?", Date.today] } }
  named_scope :expired, lambda { { :conditions => ["removed_at is NULL AND expires_on <= ?", Date.today] } }
  named_scope :soon_to_expire, lambda { { :conditions => ["removed_at is NULL AND expires_on <= ?", Date.today + 2.days] } }

  def notify_of_expiry
    if branch
      CyberstockMailer.deliver_soon_to_expire(branch.salespeople_emails, self) 
      puts "Notification for cyberstock #{stock_code} expiry delivered to #{branch.salespeople_emails.join(', ')}"
    else
      puts "Notification for cyberstock #{stock_code} expiry NOT SENT - no branch/emails to send to."
    end      
  end

  class << self
    
    def find_with_permalink( *args )
      if args.size == 1 and !args.first.kind_of?(Symbol) and args.first.to_i.to_s != args.first.to_s
        find_without_permalink :first, :conditions => { :permalink => args.first }
      else
        find_without_permalink( *args )
      end
    end
    
    alias_method_chain :find, :permalink
    
    def expiry_check
      Cyberstock.soon_to_expire.each { |x| x.notify_of_expiry }
      true
    end
  end

end