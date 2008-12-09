class ReroutingController < ApplicationController
  
  def index
    path = params[:path].first
    if path.include?("index.php")
      redirect_to "/", :status => 301
    elsif path.include?("contact.php")
      redirect_to "/contact", :status => 301
    elsif path.include?("special_opel_opc.php")
      redirect_to "/specials", :status => 301
    elsif path.include?("special_newastra_wheels.php")
      redirect_to "/specials", :status => 301
    elsif path.include?("special_hc_demo_vehicles.php")
      redirect_to "/specials", :status => 301
    elsif path.include?("special_opeltigra.php")
      redirect_to "/specials", :status => 301
    elsif path.include?("special_corsautility.php")
      redirect_to "/specials", :status => 301
    elsif path.include?("special_corsalite.php")
      redirect_to "/specials", :status => 301
    elsif path.include?("special_redtag_used.php")
      redirect_to "/specials", :status => 301
    elsif path.include?("special_capetown_g2_approved.php")
      redirect_to "/specials", :status => 301
    elsif path.include?("special_tygervalley_isuzu.php")
      redirect_to "/specials", :status => 301
    elsif path.include?("special_tygervalley_g2.php")
      redirect_to "/specials", :status => 301
    elsif path.include?("special_astra_essentia_pm.php")
      redirect_to "/specials", :status => 301
    elsif path.include?("special_n1city_g2_approved.php")
      redirect_to "/specials", :status => 301
    elsif path.include?("special_isuzukb.php")
      redirect_to "/specials", :status => 301
    elsif path.include?("astraopc.php")
      redirect_to "/new_vehicles/opel-astra-opc", :status => 301
    elsif path.include?("corsa2007.php")
      redirect_to "/new_vehicles/opel-corsa", :status => 301
    elsif path.include?("corsautility.php")
      redirect_to "/new_vehicles/opel-corsa-utility", :status => 301
    elsif path.include?("used.php")
      redirect_to "/classifieds", :status => 301
    elsif path.include?("corsa_opc.php")
      redirect_to "/new_vehicles/opel-corsa-opc", :status => 301
    elsif path.include?("corsalite.php")
      redirect_to "/new_vehicles/opel-corsa-lite", :status => 301
    elsif path.include?("astragtc.php")
      redirect_to "/new_vehicles/opel-astra-gtc", :status => 301
    elsif path.include?("n1city.php")
      redirect_to "/contact", :status => 301
    elsif path.include?("reeds.php")
      redirect_to "/", :status => 301
    elsif path.include?("isuzudiesel.php")
      redirect_to "/new_vehicles/isuzu-kb-diesel", :status => 301
    elsif path.include?("fleet_news.php")
      redirect_to "/", :status => 301
    elsif path.include?("hummer.php")
      redirect_to "/new_vehicles/hummer-h3", :status => 301
    elsif path.include?("maintenance.php")
      redirect_to "/service_and_parts/book", :status => 301
    elsif path.include?("pedal-power.php")
      redirect_to "/", :status => 301
    elsif path.include?("gallery.php")
      redirect_to "/", :status => 301
    elsif path.include?("combo.php")
      redirect_to "/", :status => 301
    elsif path.include?("qa.php")
      redirect_to "/pages/workshop-qa", :status => 301
    else
      render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
    end
  end
  
end
