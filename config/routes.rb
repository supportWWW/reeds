ActionController::Routing::Routes.draw do |map|
  map.resources :promotion_boxes


  
  map.root :controller => 'main', :action => 'index'

  map.resources :referrals, :member => { :visit => :get }
  map.resources :news_articles
  map.resources :branches
  map.resources :classifieds
  map.resources :pages
  map.resources :specials, :member => { :enquire => :post }

  #map.connect "/new_vehicles/:id", :controller => "new_vehicles", :action => "show" # Need this override 'cos of the name new_vehicles
  map.resources :new_vehicles

  map.sell_your_car "contact/sell_your_car", :controller => "contact", :action => "sell_your_car"
  map.search "/search", :controller => "search", :action => "index"
  map.find_car "/contact/find_car", :controller => "contact", :action => "find_car"
  map.callback "/contact/callback", :controller => "contact", :action => "callback"
  map.used_vehicle_enquiry "/contact/used_vehicle_enquiry", :controller => "contact", :action => "used_vehicle_enquiry"
  map.new_vehicle_enquiry "/contact/new_vehicle_enquiry", :controller => "contact", :action => "new_vehicle_enquiry"
  map.new_vehicle_book_test_drive "/contact/new_vehicle_book_test_drive", :controller => "contact", :action => "new_vehicle_book_test_drive"
  map.monthly_payment "/calculators/monthly_payment", :controller => "calculators", :action => "monthly_payment"
  map.affordability "/calculators/affordability", :controller => "calculators", :action => "affordability"
  map.book_service "service_and_parts/book", :controller => "service_and_parts", :action => "book"

  map.namespace(:admin) do |admin|

    admin.root :controller => 'dashboard', :action => 'index'
    admin.resources :attachments
    admin.resources :uploaded_images, :controller => 'images'
    admin.resources :new_vehicle_variants
    admin.resources :accessories
    admin.resources :model_ranges
    admin.resources :new_vehicles
    admin.resources :classifieds, :collection => { :expired => :get, :with_photo => :get, :no_photo => :get, :cyberstock => :get }
    admin.resources :model_variants
    admin.resources :models
    admin.resources :makes
    admin.resources :salespeople
    admin.resources :menu_items
    admin.resources :pages
    admin.resources :specials
    admin.resources :categories
    admin.resources :news_articles
    admin.resources :promotion_boxes

    admin.assign_to_branch 'branches/:branch_id/assign/:id', :controller => 'branches', :action => 'assign', :conditions => { :method => :post }
    admin.remove_assignment 'branches/:branch_id/remove_assignment/:id', :controller => 'branches', :action => 'remove_assignment', :conditions => { :method => :delete }
    admin.resources :branches

    admin.resources :referrals

    admin.logout '/logout', :controller => 'sessions', :action => 'destroy'
    admin.login '/login', :controller => 'sessions', :action => 'new'
    admin.register '/register', :controller => 'users', :action => 'create'
    admin.signup '/signup', :controller => 'users', :action => 'new'
    admin.resources :users

    admin.resource :session
    
  end
  
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  map.connect '*path' , :controller => 'rerouting' , :action => 'index'
  
end
