class SearchController < ApplicationController

  def index
  end

  def load_models
    unless params[:make_id].blank?
      @models = Model.find_all_by_make_id( params[:make_id] ).collect { |m| [ m.name, m.id ] }
      @models.insert( 0, [ 'Any model', '' ] )
      render :update do |page|
        page.replace_html( 'model_id', options_for_select( @models ) )
        page.hide( 'models_spinner' )
      end      
    end
  end

end
