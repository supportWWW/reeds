class Admin::AttachmentsController < Admin::ApplicationController

  after_filter :expire_cache, :only => [:destroy]


  def destroy
    @attachment = Attachment.find( params[:id] )
    @attachment.destroy
    remove_with_fade "attachment_#{@attachment.id}"
  end

private

  def expire_cache
    expire("news_articles")
    expire("pages")
    expire("new_vehicles")
  end
end
