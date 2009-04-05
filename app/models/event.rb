class Event < ActiveRecord::Base
  has_many :images, :class_name => "EventImage", :as => :owner, :order => :position, :dependent => :destroy

  validates_presence_of :name, :date
end
