class CalculatorsController < ApplicationController
  def monthly_payment
    @form = MonthlyPaymentForm.new( params[:form] )
    if @success = (request.post? and @form.valid?)
      @approximate_monthly_payment = @form.monthly_payment
    end
    respond_to do |format|
      format.js # index.html.erb
    end
  end

end
