class MonthlyPaymentForm < ActiveRecord::BaseWithoutTable
  column :purchase_price, :integer
  column :deposit, :integer
  column :repayment_period, :integer
  column :interest_rate, :decimal
  
  validates_presence_of :purchase_price, :repayment_period, :interest_rate, :deposit
  
  REPAYMENT_PERIODS = [12, 18, 24, 36, 48, 54, 60]
  
  def monthly_payment
    Calculator.monthly_payment(purchase_price, deposit, repayment_period, interest_rate)
  end
end