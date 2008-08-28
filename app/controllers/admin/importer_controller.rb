class Admin::ImporterController < Admin::ApplicationController
  
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

  def import_cyberstock
    if request.post?
      
      unless params[:file].blank?
        CyberstockFileImporterService.instance.process( params[:file] )
        flash[:notice] = 'The file you provided has been imported'
        redirect_to :action => 'import_cyberstock'
      else
        flash[:error] = 'You have to provide a file to upload'
      end
      
    end
  end

  def import_new_vehicles
    if request.post?
      
      unless params[:file].blank?
        NewVehicleFileImporterService.instance.process( params[:file] )
        flash[:notice] = 'The file you provided has been imported'
        redirect_to :action => 'import_new_vehicles'
      else
        flash[:error] = 'You have to provide a file to upload'
      end
      
    end
  end

  def import_mm
    
    if request.post?
      unless params[:file].blank?
        MeadMcgroutherImporterService.instance.process( params[:file] )
        flash[:notice] = 'The file you provided has been imported'
        redirect_to :action => 'import_mm'
      else
        flash[:error] = 'You have to provide a file to upload'
      end
    end
    
  end

end
