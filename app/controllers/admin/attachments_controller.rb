class Admin::AttachmentsController < Admin::ApplicationController

  def destroy
    @attachment = Attachment.find( params[:id] )
    @attachment.destroy
    remove_with_fade "attachment_#{@attachment.id}"
  end

end
