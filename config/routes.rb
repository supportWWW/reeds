ActionController::Routing::Routes.draw do |map|
  
  
  map.resources :attachments
  map.resources :images
  map.resources :new_vehicle_variants
  map.resources :accessories
  map.resources :model_ranges
  map.resources :new_vehicles
  map.resources :classifieds
  map.resources :model_variants
  map.resources :models
  map.resources :makes
  map.resources :salespeople
  map.resources :menu_items
  map.resources :pages
  map.resources :categories
  map.resources :news_articles
  
  map.assign_to_branch 'branches/:branch_id/assign/:id', :controller => 'branches', :action => 'assign', :conditions => { :method => :post }
  map.remove_assignment 'branches/:branch_id/remove_assignment/:id', :controller => 'branches', :action => 'remove_assignment', :conditions => { :method => :delete }
  map.resources :branches
  
  map.resources :referrals, :member => { :visit => :get }

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users

  map.resource :session

  map.root :controller => 'main', :action => 'index'
  
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
end
