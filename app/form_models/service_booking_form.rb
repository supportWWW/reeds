class ServiceBookingForm < ActiveRecord::BaseWithoutTable
  column :name, :string
  column :email, :string
  column :cel_phone_number, :string
  column :work_phone_number, :string
  column :problem_description, :string
  column :booking_date, :date
  column :branch, :string
  column :reg_num, :string
  
  validate :validate_booking_date
  
  validates_presence_of :name, :email, :cel_phone_number, :work_phone_number, :problem_description, :booking_date, :reg_num
  
  def booking_date
      self[:booking_date] || 3.days.from_now.to_date
  end
  
  def validate_booking_date
    if booking_date < 3.days.from_now.to_date
      errors.add :booking_date, 'should not be sooner than 3 days from now'
    end
  end
  
end