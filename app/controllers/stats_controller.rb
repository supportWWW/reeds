class StatsController < ApplicationController
  # POST /stats
  # POST /stats.xml
  def create
    if params[:parent_type].constantize.find(params[:parent_id])
      @stat = Stat.new
      @stat.parent_type = params[:parent_type]
      @stat.parent_id = params[:parent_id]
      @stat.user_agent = request.headers['User-Agent']
      @stat.remote_ip = request.remote_ip
      @stat.date = Time.zone.now.to_date
      @stat.referer = request.headers["Referer"]
      
      respond_to do |format|
        if @stat.save
          format.js { render :nothing => true }
        else
          logger.error "Error creating stats"
          logger.error $!
          format.js { render :nothing => true }
        end
      end
      
    else
      render :nothing => true
    end
  end


end
