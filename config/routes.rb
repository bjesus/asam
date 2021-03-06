Asam::Application.routes.draw do
  resources :texts

  get "home/index"

  devise_for :users
  match 'texts/editor' => 'editor#index', :via => :get
  match 'texts/editor' => 'editor#update', :via => :post
  match 'my_texts' => 'texts#my_texts', :via => :get
  
  resources :images do
    member do
      post :rate
    end
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  match 'tags/:id' => 'texts#tagged'
  match 'list' => 'texts#tagged'
  match 'tags_json' => 'texts#tags_json'
  match 'search' => 'texts#search'
  match 'texts/:id/snippet' => 'texts#snippet'
  match 'texts/:id/comment' => 'texts#comment'
  match 'images/:id/guidelines' => 'images#guidelines'
  match 'images/:id/hidden-switch' => 'images#hidden_switch'

  match 'all/:tag' => 'texts#all_tags'
  match 'links' => 'home#links'
  match 'help' => 'home#help'


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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  root :to => "texts#index"
end
