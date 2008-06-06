module ReferralsHelper

  def referral_link( referral = @referral )
    "#{public_path}#{visit_referral_path( referral)}"
  end

end
