Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'us_geos/search'
      get 'events/search'
      get 'venues/search'
      get 'incidents/search'
      get 'incidents/index'
    end
  end

  get 'places/search'
  
  #get 'api/v1/venues/search'
  
  #get 'api/v1/events/search'
  
  #get 'api/v1/usgeos/search'
  
  # this is a static page to test event creation
  get '/index_test_post', :to => redirect('/public/index_test_post.html')
  
  # This is the static about page  
  get '/about', :to => redirect('/public/about.html')


  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :events, defaults: { format: 'json' }
      resources :usgeos, defaults: { format: 'json' }
      resources :venues, defaults: { format: 'json' }
    end
  end
  
  # This is for the starting point of the angular view I started building and will finsish post final project
  namespace :ang do
    resources :welcome
  end
  
  resources :events
  
  resources :venues

  resources :places
  
  # root 'welcome#index'
  # root :controller => 'static', :action => '/public/index.html'
  # root :controller=> 'places', :action=>"search"
  root 'places#search'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
