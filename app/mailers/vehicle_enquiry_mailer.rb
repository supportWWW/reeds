class VehicleEnquiryMailer < ActionMailer::Base
  
  helper :application
  
  def used( frm, referrals = [] )
    subject    'Reeds  - Used vehicle enquiry'
    recipients ['riaanv@reeds.co.za', 'direct@reeds.co.za']
    from        "i-am-robot-dont-respond@reeds.co.za"
    sent_on    Time.now
    body       :form => frm, :referrals => referrals
  end

  def neww( frm, referrals = [])
    subject    'Reeds  - New vehicle enquiry'
    recipients ['riaanv@reeds.co.za', 'direct@reeds.co.za']
    from        "i-am-robot-dont-respond@reeds.co.za"
    sent_on    Time.now
    body       :form => frm, :referrals => referrals
  end

  def autoresponder(recipient, subject,  sent_at = Time.now)
    subject       subject
    recipients    [recipient]
    from          'i-am-robot-dont-respond@reeds.co.za'
    sent_on       sent_at
    content_type  "text/html"
  end

private

  def get_used_vehicle_recipients(frm)
    #arr = ['joergd@pobox.com']
    arr = ['support@whitewallweb.com']
    branch = Branch.find_by_id(frm.branch_id)
    if branch
      branch.salespeople.web_leads.each do |salesperson|
        arr << salesperson.email unless salesperson.email.blank?
      end
    end
    arr
  end
  
end
