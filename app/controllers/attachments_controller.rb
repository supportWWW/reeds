class AttachmentsController < ApplicationController

  before_filter :login_required
  
  def destroy
    @attachment = Attachment.find( params[:id] )
    @attachment.destroy
    remove_with_fade "attachment_#{@attachment.id}"
  end

end
