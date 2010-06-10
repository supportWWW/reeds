class FormSubmitController < ApplicationController
  def new
    @form_submit =  FormSubmit.new
  end
  
end
