module Calculator
  def self.monthly_payment(purchase_price, deposit, repayment_period, interest_rate)
    
		var intermediate = new MakeArray(fmonths);
		var i;
		var fdaily_rate = finterest/36500;
		var famount = fprice - fdeposit;
		var ftotal = 0;
	
		for (i = 0; i <= fmonths -1; i++) {
			intermediate[i] =1+30.42*fdaily_rate
		}
		
		for (i = fmonths - 2; i >= 0; i--) {
			intermediate[i] = intermediate[i] * intermediate[i+1];
		}
		
		for (i = 0; i <= fmonths-1; i++ ) {
			ftotal = ftotal  + intermediate[i];
		}

		if (fpayments == 0) {
			fpayments = ((famount*intermediate[0]-ffinal_payment)/(ftotal+1-intermediate[0]));
			obj.payments.value = Math.round(fpayments)
		} else if (fprice == 0) {
			famount =((fpayments*(ftotal+1-intermediate[0]))+ffinal_payment)/intermediate[0];
			fprice = famount + fdeposit;
			obj.price.value = Math.round(fprice)
		} else if (fdeposit == 0) {
			famount =((fpayments*(ftotal+1-intermediate[0]))+ffinal_payment)/intermediate[0];
			fdeposit = fprice - famount;
			obj.deposit.value = Math.round(fdeposit)
		} else if (ffinal_payment == 0) {
			ffinal_payment = (famount*intermediate[0])-(fpayments*(ftotal+1-intermediate[0]));
			obj.final_payment.value = Math.round(ffinal_payment)
		} else {
			fpayments = ((famount*intermediate[0]-ffinal_payment)/(ftotal+1-intermediate[0]));
			obj.payments.value = Math.round(fpayments)
		}
    
  end
end