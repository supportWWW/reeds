class Referral < ActiveRecord::Base
  
  validates_presence_of :name, :redirect_to
  
  has_many :visits
  
  class << self
    
    def select_visits( referral_id, group_by = 'referer_host' )
      connection.select_rows "select count(*), v.#{group_by} from visits v where v.referral_id = #{referral_id} group by v.#{group_by}"
    end
    
  end
  
  
end
