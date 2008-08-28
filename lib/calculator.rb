module Calculator
  def self.monthly_payment(purchase_price, deposit, repayment_period, interest_rate)
		total = 0
    intermediate = []
    
    daily_rate = BigDecimal((interest_rate / 36500).to_s)
    amount = purchase_price - deposit
    
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
end