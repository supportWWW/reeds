class Admin::ImporterController < Admin::ApplicationController
  
  after_filter :expire_classifieds, :only => [:import_stock, :import_cyberstock]
  after_filter :expire_new_vehicles, :only => [:import_new_vehicles, :import_accessories]

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
        NewVehicleFileImporterService.instance.process(params[:new_vehicle_id], params[:file])
        flash[:notice] = 'The file you provided has been imported'
        redirect_to :action => 'import_new_vehicles'
      else
        flash[:error] = 'You have to provide a file to upload'
      end
      
    end
  end

  def import_accessories
    if request.post?
      
      unless params[:file].blank?
        AccessoriesFileImporterService.instance.process(params[:new_vehicle_id], params[:file])
        flash[:notice] = 'The file you provided has been imported'
        redirect_to :action => 'import_accessories'
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

private

  def expire_classifieds
    expire("classifieds")
  end

  def expire_new_vehicles
    expire("new_vehicles")
  end
end
