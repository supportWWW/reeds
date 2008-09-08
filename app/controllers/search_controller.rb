class SearchController < ApplicationController

  before_filter :load_page, :only => :index
  
  def index
    conditions = []
    criteria = []
    
    @criteria_in_words = "" # Used for mailing find car requests
    
    # MAKE
    unless params[:make_id].blank?
      conditions << "make_id = ?"
      criteria << params[:make_id].to_i
      @criteria_in_words += "Make: #{Make.find(params[:make_id]).common_name}\n"
    end
    
    # MODEL
    unless params[:model_id].blank?
      conditions << "model_id = ?"
      criteria << params[:model_id]
      @criteria_in_words += "Model: #{Model.find(params[:model_id]).common_name}\n"
    end

    # Convert price to price range if there is only a price
    # Price is in rands (not cents)
    unless params[:price].blank?
      params[:price_range] = convert_to_price_range(params[:price])
    end
    
    # PRICE RANGE
    unless params[:price_range].blank?
      range = params[:price_range].split("|").map { |price| price.to_i * 100 }
      if range.size == 2
        conditions << "price_in_cents BETWEEN ? AND ?"
        criteria << range[0]
        criteria << range[1]
        @criteria_in_words += "Price range: Between R#{range[0] / 100} and R#{range[1] / 100}\n"
      else
        conditions << "price_in_cents > ?"
        criteria << range[0]
        @criteria_in_words += "Price range: From R#{range[0] / 100}\n"
      end
    end

    # YEAR
    unless params[:from].blank? && params[:to].blank?
      f = params[:from].blank? ? params[:to] : params[:from]
      t = params[:to].blank? ? params[:from] : params[:to]
      conditions << "year BETWEEN ? AND ?"
      criteria << f.to_i
      criteria << t.to_i
      @criteria_in_words += f == t ? "Year: #{f}\n"  : "Year: Between #{f} and #{t}\n"
    end

    unless conditions.empty?
      @results = Classified.available.paginate( :all,
                                          :page => @page, :per_page => @per_page,
                                          :conditions => [conditions.join(" AND "), *criteria])
    end
  end

  def load_models
    unless params[:make_id].blank?
      @models = Model.find_all_by_make_id( params[:make_id] ).collect { |m| [ m.name, m.id ] }
      @models.insert( 0, [ 'Any model', '' ] )
    else
      @models = [[ 'Any model', '' ]]
    end
    respond_to do |format|
      format.js
    end
  end

private

  def convert_to_price_range(price)
    p = price.to_i.roundup(10000)
    return "#{p - 10000}|#{p + 10000}"
  end
end