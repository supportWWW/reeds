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

  def affordability
    @form = AffordabilityForm.new( params[:form] )
    if @success = (request.post? and @form.valid?)
      @approximate_loan_amount = @form.affordability
    end
    respond_to do |format|
      format.js # index.html.erb
      format.html
    end
  end


end
