module Calculator
  def self.monthly_payment(purchase_price, deposit, repayment_period, interest_rate)
		total = 0
    intermediate = []
    
    daily_rate = BigDecimal(((interest_rate || 0) / 36500).to_s)
    amount = (purchase_price || 0) - (deposit || 0)
    
    0.upto(repayment_period - 1) do |i|
      intermediate[i] = BigDecimal((1 + 30.42 * daily_rate).to_s)
    end

    (repayment_period - 2).downto(0) do |i|
      intermediate[i] *= intermediate[i+1]
    end

    0.upto(repayment_period - 1) do |i|
      total += intermediate[i]
    end

  	((amount * intermediate[0]) / (total + 1 - intermediate[0])).to_i
  end
  
  def self.affordability(deposit, repayment_period, interest_rate, monthly_payment)
    interest_rate = BigDecimal(interest_rate.to_s)
	  interest_rate = interest_rate / 100.0 if interest_rate > 1
	  interest_rate = interest_rate / 12.0

    pow = 1
    0.upto((repayment_period || 0) - 1) do |t|
      pow = pow * (1 + interest_rate)
    end

    ((BigDecimal((monthly_payment || 0).to_s) * (1.0 - (1.0 + interest_rate) ** (- BigDecimal((repayment_period || 0).to_s))) / interest_rate) + BigDecimal((deposit || 0).to_s)).to_i
  end
end