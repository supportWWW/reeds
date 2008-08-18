class SearchController < ApplicationController

  before_filter :load_page, :only => :index

  def index
    conditions = []
    criteria = []
    
    # MAKE
    unless params[:make_id].blank?
      conditions << "make_id = ?"
      criteria << params[:make_id].to_i
    end
    
    # MODEL
    unless params[:model_id].blank?
      conditions << "model_id = ?"
      criteria << params[:model_id]
    end

    # PRICE RANGE
    unless params[:price_range].blank?
      price_range = params[:price_range].split("|").map { |price| price.to_i * 100 }
      if price_range.size == 2
        conditions << "price_in_cents BETWEEN ? AND ?"
        criteria << price_range[0]
        criteria << price_range[1]
      else
        conditions << "price_in_cents > ?"
        criteria << price_range[0]
      end
    end

    # YEAR
    unless params[:from].blank? && params[:to].blank?
      from = params[:from].blank? ? params[:to] : params[:from]
      to = params[:to].blank? ? params[:from] : params[:to]
      conditions << "year BETWEEN ? AND ?"
      criteria << from.to_i
      criteria << to.to_i
    end
    
    @results = Classified.paginate( :all,
                                        :page => @page, :per_page => @per_page,
                                        :include => [:make, :model],
                                        :conditions => [conditions.join(" AND "), *criteria])
  end

  def load_models
    unless params[:make_id].blank?
      @models = Model.find_all_by_make_id( params[:make_id] ).collect { |m| [ m.name, m.id ] }
      @models.insert( 0, [ 'Any model', '' ] )

      respond_to do |format|
        format.js
      end
    end
  end

end
