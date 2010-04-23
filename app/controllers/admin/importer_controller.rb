class Admin::ImporterController < Admin::ApplicationController
  
  after_filter :expire_classifieds, :only => [:import_stock, :import_cyberstock]
  after_filter :expire_new_vehicles, :only => [:import_new_vehicles, :import_accessories]

  def import_stock
    if request.post?
      
      unless params[:file].blank?
        added, @error = StockFileImporterService.instance.process( params[:file] )
        if @error.blank?
          flash[:notice] = 'The file you provided has been imported'
        else
          flash[:error] = "The file had errors."
        end
        # redirect_to :action => 'import_stock'
      else
        flash[:error] = 'You have to provide a file to upload'
      end
      
    end
  end

  def import_cyberstock
    if request.post?
      
      unless params[:file].blank?
        added, @error = CyberstockFileImporterService.instance.process( params[:file] )
        if @error.blank?
          flash[:notice] = 'The file you provided has been imported'
        else
          flash[:error] = "The file had errors."
        end
      else
        flash[:error] = 'You have to provide a file to upload'
      end
      
    end
  end

  def import_new_vehicles
    if request.post?
      
      unless params[:file].blank?
        added, @error = NewVehicleFileImporterService.instance.process(params[:new_vehicle_id], params[:file])
        if @error.blank?
          flash[:notice] = 'The file you provided has been imported'
        else
          flash[:error] = "The file had errors."
        end
      else
        flash[:error] = 'You have to provide a file to upload'
      end
      
    end
  end

  def import_accessories
    if request.post?
      
      unless params[:file].blank?
        added, @error = AccessoriesFileImporterService.instance.process(params[:new_vehicle_id], params[:file])
        if @error.blank?
          flash[:notice] = 'The file you provided has been imported'
        else
          flash[:error] = "The file had errors."
        end
      else
        flash[:error] = 'You have to provide a file to upload'
      end
      
    end
  end

  def import_mm
    
    if request.post?
      unless params[:file].blank?
        added, @error = MeadMcgroutherImporterService.instance.process( params[:file] )
        if @error.blank?
          flash[:notice] = 'The file you provided has been imported'
        else
          flash[:error] = "The file had errors."
        end
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
