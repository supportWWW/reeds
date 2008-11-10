class AffordabilityForm < ActiveRecord::BaseWithoutTable
  column :monthly_payment, :integer
  column :deposit, :integer
  column :repayment_period, :integer
  column :interest_rate, :decimal
  
  validates_presence_of :monthly_payment, :repayment_period, :interest_rate
  
  REPAYMENT_PERIODS = [12, 18, 24, 36, 48, 54, 60]
  
  def affordability
    Calculator.affordability(deposit, repayment_period, interest_rate, monthly_payment)
  end
end