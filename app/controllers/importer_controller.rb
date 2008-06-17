class ImporterController < ApplicationController
  
  before_filter :login_required
  
  def import_stock
    if request.post?
      
      unless params[:file].blank?
        StockFileImporterService.instance.process( params[:file] )
        flash[:notice] = 'The file you provided has been imported'
        redirect_to :action => 'import_stock'
      else
        flash[:error] = 'You have to provide a file to upload'
      end
      
    end
  end

  def import_mm
    
    if request.post?
      unless params[:find].blank?
        MeadMcgroutherImporterService.instance.process( params[:file] )
        flash[:notice] = 'The file you provided has been imported'
        redirect_to :action => 'import_mm'
      else
        flash[:error] = 'You have to provide a file to upload'
      end
    end
    
  end

end
