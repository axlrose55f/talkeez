ActionController::Routing::Routes.draw do |map|
 
  map.root :controller => 'movies'

  map.auto_complete '/:controller/:action',
     :requirements => { :action => /auto_complete_for_\S+/ },
     :conditions => { :method => :get }
     
  map.resources :trivias

  map.resources :awards
  
  map.resources :award_types ,:member => {:showCategories => :get }
 
  map.resources :albums , :member => {:edittracks => :get,
                                      :editgenres => :get,
                                      :editartists => :get,
                                      :editreviews => :get,
                                      :tracks => :get,
                                      :artists => :get,
                                      :reviews => :get,
                                      :videos => :get,
                                      :updategenres => :put,
                                      :updateartists => :put}

  map.resources :tracks , :member => {:delete_track => :get }
  
  map.resources :rating, :member => {:rate => :put, 
                                      :rate => :post }
  
  map.resources :genres
  
  map.resources :moods
   
  map.resources :ragas
  
  map.resources :videos , :only => [:index, :show]
  
  # Login related stuff  
  map.resources :users, :member => { :movies => :get,
                                     :reviews => :get,
                                     :videos => :get,
                                     :friends => :get,
                                     :artists => :get,
                                     :addRole => :put,
                                     :deleteRole => :delete} 
  map.resources :user_sessions
    
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.fblogin "fblogin", :controller => "user_sessions", :action => "create", :requirements => { :method => :post} 
  
     
  # map.open_id_complete "session", :controller => "user_sessions", 
  #                                 :action => "create", 
  #                                 :requirements => { :method => :get} 
 

  map.resources :artists, :member => { :filmography => :get,
                                       :reviews => :get,
                                       :awards => :get,
                                       :editawards => :get,
                                       :editmovies => :get,
                                       :addCastDetail => :put,
                                       :addAward => :put,
                                       :videos => :get,
                                       :addVideo => :put,  
                                       :rate => :post,
                                       :editArtistRole => :get,
                                       :updateArtistRole => :put} ,
                          :collection => {:search => :get } 
  
  map.resources :movies, :member => { :editartists => :get,
                                      :editgenres => :get,
                                      :editawards => :get,
                                      :editreviews => :get,
                                      :showcast => :get,
                                      :reviews => :get,
                                      :awards => :get,
                                      :videos => :get,
                                      :addVideo => :put,   
                                      :updategenres => :put,
                                      :addCastDetail => :put,
                                      :addGenre => :put,
                                      :addReview => :put,                                      
                                      :deleteGenre => :delete,
                                      :addAward => :put,
                                      :deleteAward => :delete,                                      
                                      :deleteCastDetail => :delete,
                                      :updateawards => :put,
                                      :updateartists => :put,
                                      :rate => :post} ,
                         :collection => {:search => :get }         

  map.resources :movie_roles

  # Javascript based routes
  map.connect ':controller/:action.:format'
  

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
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
