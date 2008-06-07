class Salesperson < ActiveRecord::Base
  has_many :assignments
  has_many :branches, :through => :assignments
  
  validates_presence_of :name, :phone, :email
  
  class << self
    
    def find_not_in_branch( branch_id )
      find_by_sql [ 'select s.* from salespeople s where s.id not in ( select a.salesperson_id from assignments a where a.branch_id = ? ) order by s.name', branch_id ] 
    end
    
  end
  
end
