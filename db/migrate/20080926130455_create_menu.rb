class CreateMenu < ActiveRecord::Migration
  def self.up
    MenuItem.delete_all
    Page.delete_all
    
    
    MenuItem.create!(:title => "Home", :path => "/", :position => 1, :depth => 0)

    specials_page = Page.create!(:title => "Specials", :text => "No text")
    finance_page = Page.create!(:title => "Finance", :text => "No text")
    buying_tips_page = Page.create!(:title => "Buying Tips", :text => "No text")

    vehicles = MenuItem.create!(:title => "Vehicles", :path => "/new_vehicles", :position => 2, :depth => 0)
    MenuItem.create!(:title => "New cars", :path => "/new_vehicles", :parent => vehicles, :position => 1, :depth => 1)
    MenuItem.create!(:title => "Used cars", :path => "/classifieds", :parent => vehicles, :position => 2, :depth => 1)
    MenuItem.create!(:title => "Current special offers", :page => specials_page, :parent => vehicles, :position => 3, :depth => 1)
    MenuItem.create!(:title => "Finance", :page => finance_page , :parent => vehicles, :position => 4, :depth => 1)
    MenuItem.create!(:title => "Buying tips", :page => buying_tips_page , :parent => vehicles, :position => 5, :depth => 1)

    trucks = MenuItem.create!(:title => "Trucks", :path => "/trucks/n_series", :position => 3, :depth => 0)
    MenuItem.create!(:title => "N series", :path => "/trucks/n_series", :parent => trucks, :position => 1, :depth => 1)
    MenuItem.create!(:title => "F series", :path => "/trucks/f_series", :parent => trucks, :position => 2, :depth => 1)

    workshop_page = Page.create!(:title => "Workshop Q&A", :text => "No text")
    warranties_page = Page.create!(:title => "Warranties", :text => "No text")
    parts_page = Page.create!(:title => "Parts", :text => "No text")

    after_sales_serives = MenuItem.create!(:title => "After Sales Service", :page => workshop_page, :position => 3, :depth => 0)
    MenuItem.create!(:title => "Workshop Q&A", :page => workshop_page , :parent => after_sales_serives, :position => 1, :depth => 1)
    MenuItem.create!(:title => "Service bookings", :path => "/service_and_parts/book" , :parent => after_sales_serives, :position => 2, :depth => 1)
    MenuItem.create!(:title => "Warranties", :page => warranties_page , :parent => after_sales_serives, :position => 3, :depth => 1)
    MenuItem.create!(:title => "Parts", :page => parts_page , :parent => after_sales_serives, :position => 4, :depth => 1)

    about_page = Page.create!(:title => "About Us", :text => "No text")
    rental_page = Page.create!(:title => "Reeds Car Rental", :text => "No text")
  
    company = MenuItem.create!(:title => "Company", :page => about_page, :position => 4, :depth => 0)
    MenuItem.create!(:title => "About us", :page => about_page , :parent => company, :position => 1, :depth => 1)
    MenuItem.create!(:title => "Reeds car rental", :page => rental_page , :parent => company, :position => 2 , :depth => 1)
    MenuItem.create!(:title => "Contact us", :path => "/contact", :parent => company, :position => 3 , :depth => 1)

    downloads_page = Page.create!(:title => "Downloads", :text => "No text")
    tell_us_page = Page.create!(:title => "Tell Us", :text => "No text")
    future_page = Page.create!(:title => "Future GM Models", :text => "No text")

    interactive = MenuItem.create!(:title => "Interactive", :page => downloads_page, :position => 5, :depth => 0)
    MenuItem.create!(:title => "Downloads", :page => downloads_page , :parent => interactive, :position => 1, :depth => 1)
    MenuItem.create!(:title => "Tell us", :page => tell_us_page , :parent => interactive, :position => 2, :depth => 1)
    MenuItem.create!(:title => "Request a stock sheet", :path => "/stocklists/subscribe" , :parent => interactive, :position => 3, :depth => 1)
    MenuItem.create!(:title => "What can I afford", :path => "/calculators/what_can_i_afford" , :parent => interactive, :position => 4, :depth => 1)
    MenuItem.create!(:title => "Future GM models", :page => future_page , :parent => interactive, :position => 5, :depth => 1)
    MenuItem.create!(:title => "Subscribe to newsletter", :path => "/newsletters/subscribe", :parent => interactive, :position => 6, :depth => 1)

    MenuItem.create!(:title => "Contact us", :path => "/contact", :position => 6, :depth => 0)
  end

  def self.down
  end
end
