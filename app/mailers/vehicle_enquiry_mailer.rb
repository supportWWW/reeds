class VehicleEnquiryMailer < ActionMailer::Base
  
  helper :application
  
  def used( frm )
    subject    'Reeds  - Used vehicle enquiry'
    recipients ['joergd@pobox.com', 'direct@reeds.co.za']
    from        "i-am-robot-dont-respond@reeds.co.za"
    sent_on    Time.now
    body       :form => frm
  end

  def neww( frm )
    subject    'Reeds  - New vehicle enquiry'
    recipients ['joergd@pobox.com', 'direct@reeds.co.za']
    from        "i-am-robot-dont-respond@reeds.co.za"
    sent_on    Time.now
    body       :form => frm
  end

private

  def get_used_vehicle_recipients(frm)
    arr = ['joergd@pobox.com']
    branch = Branch.find_by_id(frm.branch_id)
    if branch
      branch.salespeople.web_leads.each do |salesperson|
        arr << salesperson.email unless salesperson.email.blank?
      end
    end
    arr
  end
end
