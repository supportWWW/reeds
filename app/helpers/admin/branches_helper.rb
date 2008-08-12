module Admin::BranchesHelper

  def link_to_assign_salesperson( salesperson, branch = @branch )
    link_to_remote 'Assign to this branch', :url => admin_assign_to_branch_path( :id => salesperson, :branch_id => branch ), :method => :post
  end

  def link_to_remove_assignment( assignment )
    link_to_remote 'Remove assignment', :url => admin_remove_assignment_path( :id => assignment.salesperson_id, :branch_id => assignment.branch_id ), :method => :delete
  end
  
end
