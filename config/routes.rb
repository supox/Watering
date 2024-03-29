WateringProject::Application.routes.draw do

  root to: 'static_pages#home'
  match "/about", to: "static_pages#about"
  match "/contact", to: "static_pages#contact"

  match '/forgot', to: "users#forgot"
  match '/reset/:reset_code' => "users#reset", :via => [:get, :put], as: :reset 
  match "/time", to: "time#index"
  
  resources :sprinklers do
    member do
      get :configuration
        get :new_log
        post :create_log
      
    end
    resources :schedules, except: [ :index, :show ]
    resources :valves do
      member do # Valf 2
        get :new_irrigation
        post :create_irrigation
      end
    end
    resources :sensors do
      member do # Sensor readings
        get :new_reading
        post :create_reading
      end
      resources :alarms 
    end
  end
  
  resources :users, except: [:index]
  
  resources :sessions, only: [:new, :create, :destroy]  

  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
