module Admin::ReferralsHelper

  def referral_link( referral = @referral )
    "#{public_path}#{visit_referral_path( referral)}"
  end

  def referral_graph( referral = @referral )    
     chart = GoogleChart::PieChart.new('600x200', "Visits per referer hostname",false) do |pc|
      Referral.select_visits( referral.id ).each do |d|
        pc.data "#{d[1]} ( #{d[0]} ) ", d[0].to_i
      end
      pc.show_labels = true
    end
    image_tag chart.to_url, :alt => ''
  end
  
end
