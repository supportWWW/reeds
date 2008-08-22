class CalculatorsController < ApplicationController
  def monthly_payment
    @form = MonthlyPaymentForm.new( params[:form] )
    if @success = (request.post? and @form.valid?)
      @approximate_monthly_payment = 1000
    end
    respond_to do |format|
      format.js # index.html.erb
    end
  end

end
