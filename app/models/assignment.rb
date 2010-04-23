class Assignment < ActiveRecord::Base
  belongs_to :branch
  belongs_to :salesperson
  
  validates_presence_of :branch_id, :salesperson_id
  validates_uniqueness_of :salesperson_id, :scope => :branch_id
  
  class << self 
    
    def find_by_branch_and_salesperson( branch_id, salesperson_id )
      find :first, :conditions => { :salesperson_id => salesperson_id, :branch_id => branch_id }, :include => :branch
    end
    
  end
  
end
