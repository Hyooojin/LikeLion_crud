Rails.application.routes.draw do
 
  root 'question#index' 
  
  get 'instas/index'

  resources :instas
    
  # get 'instas/index'

  # get 'instas/new'

  # get 'instas/show'

  # get 'instas/create'

  # get 'instas/edit'

  # get 'instas/update'

  # get 'instas/destroy'

  

  # get 'insta/index'

  # get 'insta/new'

  # get 'insta/create'

  # get 'insta/show'

  # get 'insta/edit'

  # get 'insta/update'

  # get 'insta/destroy'

  
  
  get 'question/index'

  get 'question/new'

  get 'question/create'

  get 'question/show'

  get 'question/edit'

  get 'question/update'

  get 'question/destroy'
  
  get 'question/sign_up'
  
  get 'question/sign_up_process'
  
  get 'question/login'
  
  get 'question/login_process'

  get 'question/logout'
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
