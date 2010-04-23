class Branch < ActiveRecord::Base

  include ImageHelper

  has_many :assignments
  has_many :salespeople, :through => :assignments, :dependent => :destroy
  
  validates_presence_of :name

  def salespeople_emails
    emails = []
    salespeople.each do |salesperson|
      if salesperson.salesperson?
        emails << salesperson.email
      end
    end
    return emails
  end
end
