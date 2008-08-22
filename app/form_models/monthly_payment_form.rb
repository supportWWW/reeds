class MonthlyPaymentForm < ActiveRecord::BaseWithoutTable
  column :purchase_price, :integer
  column :deposit, :integer
  column :repayment_period, :integer
  column :interest_rate, :decimal
  
  validates_presence_of :purchase_price, :repayment_period, :interest_rate
  
  REPAYMENT_PERIODS = [12, 18, 24, 36, 48, 54, 60]
end