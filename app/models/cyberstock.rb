class Cyberstock < Classified

  has_permalink [:humanize, :stock_code]

  belongs_to :branch
  
  named_scope :live, lambda { { :conditions => ["removed_at is NULL AND expires_on > ?", Date.today] } }
  named_scope :expired, lambda { { :conditions => ["removed_at is NULL AND expires_on <= ?", Date.today] } }
  named_scope :soon_to_expire, lambda { { :conditions => ["removed_at is NULL AND expires_on <= ?", Date.today + 2.days] } }
  named_scope :all, :conditions => ["removed_at is NULL"]
  
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
      Branch.all.each do |branch|
        unless branch.salespeople_emails.empty?
          cyberstocks = Cyberstock.soon_to_expire.find(:all, :conditions => { :branch_id => branch.id })
          unless cyberstocks.empty?
            CyberstockMailer.deliver_soon_to_expire(branch.salespeople_emails, cyberstocks) 
            puts "Notification for cyberstocks expiry delivered to #{branch.salespeople_emails.join(', ')}"
          end
        end
      end
      true
    end

  end

end