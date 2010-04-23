class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  def index
    @events = paginate(Event, :order => "created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # To view individual images
  def image
    @event = Event.find(params[:id])
    @image = EventImage.find(params[:image_id])
  end
end
